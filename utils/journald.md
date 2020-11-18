# Using `systemctl`

[Source](https://www.loggly.com/ultimate-guide/using-systemctl/)

List all service unit files:

    # systemctl list-unit-files --type service

List all active and running service units:

    # systemctl list-units --type service --state running

List dependencies of a service (e.g. docker):

    # systemctl list-dependencies docker.service

List all failed units:

    # systemctl --failed

Check if a particular service (e.g. docker) failed:

    # systemctl is-failed docker.service

Check if a service (e.g. docker) is enabled:

    # systemctl is-enabled docker.service

Analyze boot time:

    # systemd-analyze

Show boot time by service:

    # systemd-analyze blame

# Managing Journal Size

[Source](https://www.loggly.com/ultimate-guide/managing-journal-size/)

Show disk usage of journals:

    $ journalctl --disk-usage

Delete old journals by setting a size limit:

    # journalctl --vacuum-size 256M

Delete old journals by setting a date/time limit (using "s", "m", "h", "days",
"months", "weeks" and "years"):

    # journalctl --vacuum-time 90days

Delete old journals by setting a file limit:

    # journalctl --vacuum-files 32

Verify the journal:

    # journalctl --verify

# Configuration

[Source](https://www.loggly.com/ultimate-guide/linux-logging-with-systemd/)

Journal path:

    /var/log/journal

Main configuration file:

    /etc/systemd/journald.conf

Possible locations for additional configuration:

    /etc/systemd/journald.conf.d/*.conf
    /run/systemd/journald.conf.d/*.conf
    /usr/lib/systemd/journald.conf.d/*.conf

Important parameters:

- Storage
    - none: journal turned off
    - volatile: store in memory and in `/run/log/journal`, if directory exists
    - persistent: store in `/var/log/journal`
    - auto: store in `/var/log/journal`, if directory exists, otherwise in `/run/log/journal`
- Compress
    - yes
    - no
- SystemKeepFree: how much disk space to leave free for other programs
- RuntimeKeepFree: like SystemKeepFree, but for the volatile storage setting
- ForwardToSyslog: whether or not to forward to the sysloc daemon, if listening
- MaxLevelStore: maximum level of logs to store (including lower levels, e.g. if
  the setting is 3, only err, crit, alert and emerg are logged)
    - 0/emerg
    - 1/alert
    - 2/crit
    - 3/err
    - 4/warning
    - 5/notice
    - 6/info
    - 7/debug

See also journald.conf(5)

# Using journalctl

[Source](https://www.loggly.com/ultimate-guide/using-journalctl/)

Display all journal entries from the beginning:

    $ journalctl

Display all journal entries from the current boot:

    $ journalctl -b

Display all journal entries from one boot before:

    $ journalctl -b -1

List system's boots (use the first output field as an offset to show previous
boots):

    $ journalctl --list-boots

Define time ranges:

    $ journalctl --since "1 hour ago" --until "30 minutes ago"

Use time stamps like `YYYY-MM-DD HH:MM:SS` for more accuracy:

    $ journalctl --since "2020-11-16 08:00:00" --until "2020-11-16 14:00:00"

List messages of a specific unit (e.g. docker):

    $ journalctl -u docker.service

List messages from multiple units (e.g. docker and nginx):

    $ journalctl -u docker.service nginx.service

Follow the log (like `tail -f`):

    $ journalctl -f

Print the n latest log messages:

    $ journalctl -n 100

Specify an output format:

    $ journalctl -o [format]
    $ journalctl --output [format]

The following formats are supported:

- jsonwill: one long JSON line
- json-pretty: pretty-printed JSON
- verbose: more details
- cat: short form
- short-monotonic: short, with precise time stamps

Filter by priority (level):

    $ journalctl -p "emerg"

Filter by priority range:

    $ journalctl -p "emerg".."err"

Filter for a specific user id (find out using `id [username]`):

    $ journalctl _UID=1000

Filter by an identifier (e.g. docker):

    $ journalctl -t docker

# Forward Output to journald

Forward output of a program (`ls /tmp`) to journald:

    $ systemd-cat ls /tmp

Set a log priority (warning):

    $ systemd-cat -p debug ls /tmp

Set a log identifier (health):

    $ systemd-cat -t health ls /tmp

# Syslog

[Source](https://www.loggly.com/ultimate-guide/centralizing-with-syslog/)

if needed...
