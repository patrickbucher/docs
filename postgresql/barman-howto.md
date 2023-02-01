# Barman

PostgreSQL Point in Time Recovery using [Barman](https://pgbarman.org/)

## Setup, Prerequisites

I'm using Arch Linux with PostgreSQL 14.6, which stores its data under
`/var/lib/postgres/data`, owned by `postgres:postgres`.

Python (version 3.10.9) with Pip and venv is installed.

The deployment shown here is **against the recommendations** of the Barman
project: A [local backup](https://docs.pgbarman.org/release/3.3.0/#local-backup)
is used, not a remote backup to a dedicated host! The goal of the setup shown
here is to restore the database in order to undo database operations that have
been performed erroneously in the application managing the database, not to
handle issues related to the entire host.

This makes a lot of things easier, since no separate user or management of SSH
keys is needed.

The `postgres` user is used for all tasks, because it doesn't work in another
way using the local deployment.

## Password for `postgres` User

If the `pg_hba.conf` [is set to
`trust`](https://dba.stackexchange.com/q/322568/267829), this step can be
skipped.

Otherwise, set a password for the `postgres` user (`pgpw` is used as a weak
password here, standing for "postgres password"):

    $ sudo -u postgres psql
    postgres=# ALTER USER postgres WITH PASSWORD 'pgpw';

Save the same password into `~postgres/.pgpass`:

    $ sudo su - postgres
    $ echo 'localhost:5432:*:postgres:pgpw' > ~postgres/.pgpass
    $ chmod 600 ~postgres/.pgpass

## Installing Barman

Barman is installed in the most recent version (3.3) into `/opt/barman`:

    $ sudo mkdir /opt/barman
    $ sudo chown -R postgres:postgres /opt/barman

Switch to user `barman` to perform the following step:

    $ sudo su - postgres
    barman$ cd /opt/barman
    barman$ python3 -m venv env
    barman$ . env/bin/activate
    barman$ pip install barman==3.3.0

With your regular user, make a some links within `$PATH` for convenience, e.g.:

    $ sudo ln -s /opt/barman/env/bin/barman /usr/local/bin/barman

The WAL should be archived into a separate folder:

    $ sudo mkdir -p /var/lib/barman/[database]/incoming

Replace `[database]` with the proper database name.

Own the directory by `barman`, and give write permission to its group:

    $ sudo chown -R postgres:postgres /var/lib/barman
    $ sudo chmod -R 700 /var/lib/barman

## Configuration

see [Documentation](https://docs.pgbarman.org/release/3.3.0/#configuration)

### PostgreSQL

First, the PostgreSQL configuration must be adjusted so that it writes the WAL
into barman's directory (edit `/var/lib/postgres/data/postgresql.conf`):

    archive_mode = on
    wal_level = replica
    archive_command = 'test ! -f /var/lib/barman/[database]/incoming/%f && cp %p /var/lib/barman/[database]/incoming/%f'
    archive_timeout = 900

Notice that the `barman-wal-archive` variant of the `archive_command` does not
work in the `local-rsync` setup.

Having saved those changes, restart PostgreSQL and check its status:

    $ sudo systemctl restart postgresql.service
    $ sudo systemctl is-active postgresql.service
    active

Run your application and make sure it behaves like before.

### Barman

Barman has a global (`/etc/barman.conf`) and a per-server
(`/etc/barman.d/[server]`) configuration file:

    $ sudo touch /etc/barman.conf
    $ sudo mkdir /etc/barman.d
    $ sudo chown postgres:postgres /etc/barman.conf
    $ sudo chown -R postgres:postgres /etc/barman.d

The main config file (`/etc/barman.conf`) is configured as follows:

```ini
[barman]
barman_user = postgres
configuration_files_directory = /etc/barman.d
barman_home = /var/lib/barman
log_file = /var/log/barman.log
log_level = DEBUG
compression = gzip
```

Notice that the _data_ directory `/var/lib/barman` is used (rather then the
installation directory `/opt/barman`) for the `barman_home`. The `log_level` can
be reduced to `INFO` for production.

Make sure to create the log file:

    $ sudo touch /var/log/barman.log
    $ sudo chown postgres:postgres /var/log/barman.log

The Barman documentation uses `pg` as a placeholder for the server name. Since
only the local server is configured in the setup described here, it can be
literally called `pg`. As an alternative, use the name of your application or
database. The according server config file `/etc/barman.d/[database].conf` is
set up as follows:

```ini
[database]
description = "local PostgreSQL server"
conninfo = host=localhost user=postgres password=pgpw dbname=[database]
backup_method = local-rsync
parallel_jobs = 1
archiver = on
backup_options = concurrent_backup
```

Replace `pgpw` with the real PostgreSQL password for `postgres`, and use the
actual name for `[database]` (in square brackets, e.g. `[foobar]`).

As the `backup_method`, `local-rsync` is used. (The other options have been
taken from the documentation without further consideration.)

Check the current configuration:

    $ sudo -iu postgres barman check [database]
    Server [database]:
        WAL archive: FAILED (please make sure WAL shipping is setup)
        PostgreSQL: OK
        superuser or standard user with backup privileges: OK
        ...

The WAL archive is on `FAILED`, but will be initialized in the next step. **The
other lines must say `OK`!**

## Prepare WAL Archive

Not that everything is configured, the WAL archive can be initialized.

Create the initial WAL archive as follows:

    $ sudo -iu postgres barman switch-wal --force --archive [database]

If this doesn't work (follow `/var/log/barman.log` for details), enforce the
switch to a new WAL file:

    $ sudo -iu postgres psql [your db] -c 'select pg_switch_wal()'
     pg_switch_wal
    ---------------
     0/3000000
    (1 row)

Then retry the above `barman switch-wal` command.

Check the current configuration and archive:

    $ sudo -iu postgres barman check [database]
    Server [database]:
        PostgreSQL: OK
        superuser or standard user with backup privileges: OK
        wal_level: OK
        directories: OK
        retention policy settings: OK
        backup maximum age: OK (no last_backup_maximum_age provided)
        backup minimum size: OK (0 B)
        wal maximum age: OK (no last_wal_maximum_age provided)
        wal size: OK (0 B)
        compression settings: OK
        failed backups: OK (there are 0 failed backups)
        minimum redundancy requirements: OK (have 0 backups, expected at least 0)
        local PGDATA: OK (Access to local PGDATA)
        systemid coherence: OK (no system Id stored on disk)
        archive_mode: OK
        archive_command: OK
        continuous archiving: OK
        archiver errors: OK

If everything is `OK`, you're set.

## Create a Backup

Now it's time to create the initial backup:

    $ sudo -iu postgres barman backup [database]

The backups can be listed as follows:

    $ sudo -iu postgres barman list-backups [database]
    [database] 20230125T111904 - Wed Jan 25 11:19:05 2023 - Size: 43.4 MiB - WAL Size: 0 B

The shown date is the **earliest** point in time for point in time recoveries;
the WAL archive is written continuously from that point.

Use the first (server) and second (timestamp) columns as the identifier to show
and check a backup:

    $ sudo -iu postgres barman show-backup [database] 20230125T111904
    $ sudo -iu postgres barman check-backup [database] 20230125T111904
    $ echo $?
    0

Check the status of your server anytime:

    $ sudo -iu postgres barman status [database]

## Recovery

Now it's time for action.

Save the current timestamp to be used for the recovery:

    $ date | tee before.timestamp
    Wed Jan 25 11:25:54 AM CET 2023

Run your application and do something harmful (e.g. deleting an entry, or
modifying some values).

Stop your application as soon as possible. Also stop the database server:

    $ sudo systemctl stop postgresql.service

The PostgreSQL data directory is going to be purged; consider creating a backup
of the current state:

    $ sudo cp -r /var/lib/postgres/data/ postgres.backup

Now empty the PostgreSQL data directory:

    $ sudo find /var/lib/postgres/data -mindepth 1 -delete

For the recovery, you need the barman server name (first column) and timestamp
of the backup (second column name) to be used:

    $ sudo -iu postgres barman list-backups [database] | cut -d' ' -f 1,2
    [database] 20230125T111904

Recover the database from the point in time before (see `before.timestamp`):

    $ sudo -iu postgres barman recover \
        --target-action pause \
        --target-time='2023-01-25 11:25:00' \
        pg 20230125T111904 /var/lib/postgres/data

With `--target-action pause`, WAL archiving is paused for the time being.

The command will issue a warning like this:

    postgresql.conf line 244: archive_command = false

WAL archiving is currently deactivated.

A file `/var/lib/postgres/data/postgresql.auto.conf` has been created, which
will run the recovery upon start of the PostgreSQL service.

Double-check the `restore_command` and `recovery_target_time` in that file.

Follow the journal of PostreSQL in one terminal:

    $ sudo journalctl -fu postgresql.service

And start PostgreSQL in another terminal:

    $ sudo systemctl start postgresql.service

If everything worked fine, test the recovered data.

### Reinstate WAL Archive 

Notice that the database is in recovery mode, which can be shown as follows:

    $ sudo -iu postgres psql -c 'select pg_is_in_recovery()'
     pg_is_in_recovery 
    -------------------
     t
    (1 row)

During recovery mode, writing operations are restricted, because WAL archiving
has been deactivated.

If the data was recovered as intended (double-check directly in the database or
with read-only operations from the application), it's time to continue normal
operations.

Stop the server:

    $ sudo systemctl stop postgresql.service

First, fix the PostgreSQL configuration (`/var/lib/postgres/data/postgresql.conf`) replacing:

    archive_command = false

With the original command (commented directly above):

    archive_command = 'test ! -f /var/lib/barman/pg/incoming/%f && cp %p /var/lib/barman/pg/incoming/%f'
    
Then start the server again:

    $ sudo systemctl start postgresql.service

Second, finish recovery mode and continue normal operation (including WAL
archiving):

    $ sudo -iu postgres psql -c 'select pg_wal_replay_resume()'
     pg_wal_replay_resume 
    ----------------------
     
    (1 row)

## Further Considerations for Production

- Run `select pg_switch_wal()` using `psql` to enforce switching to a new WAL file.
- Run `barman cron` every minute to archive the WAL files.
- Run `barman backup` on a regular basis (daily).
    - Run `barman check-backup` afterwards.
    - Run `barman delete` to get rid of older base backups (consider keeping two
      or three).
- Replicate backup folder to S3.
- Consider configuring `last_backup_maximum_age` option in `/etc/barman.conf`.
