# PostgreSQL Setup

In `postgresql.conf` (`/var/lib/postgres/data/` on Arch Linux, `/etc/postgresql/14/main/postgresql.conf` on Ubuntu), set the following options to activate log archive:

```
archive_mode = on
wal_level = replica
archive_command = 'test ! -f /var/lib/barman/pg/incoming/%f && cp %p /var/lib/barman/pg/incoming/%f'
archive_timeout = 900
```

has no effect (in postgres.conf)

    restore_command = '/var/lib/barman/env/bin/barman get-wal -P pg %f > %p'

# Setup

- psycopg2 >= 2.4.2
- PostgreSQL >= 10
- postgres client package (Ubuntu/Debian)

# Configuration

- rsync: easier
- WAL streaming only for PostgreSQL > 9.4

- ini format
- main configuration: /etc/barman.conf
- server configuration: /etc/barman.d/[name].conf

- global options under `[barman]` section
- server options under `[pg]`, where `pg` stands for the server name
    - e.g. `local`
    - can override global config options
    - see barman(5)

main config:

```
[barman]
barman_user = postgres
configuration_files_directory = /etc/barman.d
barman_home = /var/lib/barman
log_file = /var/log/barman/barman.log
log_level = INFO
compression = gzip
recovery_options get-wal
```

server config:

```
[pg]
description = "PostgreSQL server"
conninfo = host=localhost user=postgres dbname=aect
backup_method = local-rsync
parallel_jobs = 1
archiver = on
backup_options = concurrent_backup
```

enforce wal export:

    sudo -u postgres psql aect -c 'select pg_switch_wal()'

run

    $ barman switch-wal --force --archive pg
    $ barman check pg
    $ barman backup pg

    $ barman list-backups pg
    pg 20230118T172515 - Wed Jan 18 17:25:16 2023 - Size: 37.7 MiB - WAL Size: 0 B
    pg 20230118T170414 - Wed Jan 18 17:04:15 2023 - Size: 37.7 MiB - WAL Size: 64.2 KiB

    $ barman show-backup pg 20230118T172515
    $ barman check-backup pg 20230118T172515
    $ echo $?
    0

    $ barman cron
    $ barman status pg

    $ barman recover --get-wal --target-time='2023-01-18 17:26:00' pg 20230118T172515 /var/lib/postgres/data/

TODO: what does `barman cron` do?
