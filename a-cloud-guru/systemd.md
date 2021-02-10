# systemd

Outline:

1. Linux Boot Process
2. Traditinal `init` System
3. Upstart
4. systemd
    1. Architecture
    2. Units
    3. Services
    4. Journal
    5. Targets
    6. Containers
5. Summary

## Linux Boot Process

1. BIOS
2. Boot Loader
3. Kernel
4. Mount Disk
5. `/sbin/init`

## Traditional init System

- runlevels:
    - 0: halt
    - 1: single user mode (root only)
    - 2: multi user mode (no networking)
    - 3: multi user mod (networking enabled)
    - 4: unused (free for custom use by distributions)
    - 5: multi user mode with GUI (and networking)
    - 6: reboot
- init scripts in `/etc/rc.d` (Red Hat) or `/etc/init.d` (Debian)
    - sub-folders per runlevel (`rc0.d`, `rc1.d`)
    - contain start/kill scripts 
- `rc.local`: custom configuration
- issues:
    - sequential startup (slow)
    - spawns a lot of processes, loads a lot of libraries (see `$PID` after
      start)
    - doesn't respond well to changes

## Upstart

- Ubuntu's replacement for 6.10
- asynchronuous startup, allows service to run in parallel
- event-based (trigger jobs)
- monitors and restarts services, if needed
- still relied on "x before y" model

## systemd

- started by Lennart Poettering (Red Hat)
- first release in 2010
- inspired by `launchd` (Apple)
    - systemd provides all sockets for daemons
    - dependent daemons started using socket activation (as needed)
- pros:
    - faster startup time
    - daemon replacement without loosing messages (systemd provides sockets)
    - universal logging framework
    - services monitored and re-started if needed
- cons:
    - higher complexity: need to re-learn
        - unintelligible error messages ("just Google the error message")
    - non-deterministic startup: hard to debug
    - breaking with traditions: need to rewrite
    - binary logs
    - feature-creep
        - journald (syslog)
        - resolvd (DNS)
        - mounts (fstab)
        - timers (cron)
        - containers (nspawn)
        - boot loader
        - ...
    - conduct with bug reports
    - not portable (Linux-specific due to cgroups)
    - desktop ready, network not...
- widely adopted nowadays
    - Fedora, Red Hat (since 2010)
    - Debian: 2014 (Devuan fork)
    - Ubuntu followed (replaced Upstart)
    - most major Linux distributions
    - alternatives:
        - OpenRC (default for Gentoo, Alpine; available for Arch, FreeBSD,
          NetBSD)
        - runit (Void Linux)
        - BSD init systems (classical `init`, without runlevels)

### Architecture

- daemons: `systemd`, `journald`, `networkd`, ...
- utilities: `systemctl`, `journalctl`, ...
- core: service, timer, mount, ...
- libraries: dbus-1, libpam, ...
- kernel: cgroups, autofs, kdbus
- process management using cgroups (2006/2007)
    - slices: hierarchical groups of processes get their part of the resources
    - `system.slice`: for system services
    - `user.slice`: for each user
    - `systemd-cgls`, `systemd-cgtop`

### Units

- Unix: everything is a file
- systemd: everything is a unit: `something.[unit]`
    - types: scope, slice, socket, service, path, timer, mount, ...
    - `systemd.unit (5)`
- see `/etc/systemd/system`
- `systemctl` commands:
    - `[none]`: lists all units
    - `status`: shows the system status (unit/slice tree)
    - `status [unit]`: shows the status of a specific unit
    - `enable [unit]`: start unit automatically
        - creates a symlink fro `/etc/systemd/system/...` to the unit file
    - `disable [unit]`: do not start unit automatically
        - removes the symlink
    - `start [unit]`: start the unit
    - `stop [unit]`: stop the unit
    - `help [unit]`: show help (if available)
    - `-H [host]`: runs the `systemctl` on a remote host (via SSH)
        - `systemctl -H foo.bar.com status`

### Services

- Demo: generic service (locally)
- Demo: custom service (remotely)
- Demo: oneshot service (remotely)
- Demo: path unit (remotely)
- common tasks:
    - check status using `systemctl is-enabled` (enabled/disabled) and `systemctl is-active`
        - `active`: running
        - `inactive`: not running
        - `failed`: exited with an error code (not 0)
    - `systemctl reload [pattern]`: ask units matching `pattern` to reload _their_ configuration
    - `systemctl mask [unit]`: prevents a unit from being started (by accident)
        - unit file is set as a symlink to `/dev/null`
    - `systemctl unmask [unit]`: allow the unit to be started again
        - remove the symlink to `/dev/null` again

### Journal

- the systemd Journal is a binary data base file that logs:
    - kernel log messages
    - system log messages
    - stdout/stderr of any system service
    - SELinux audit records
    - output from `systemd-cat`
- messages are logged to `/run/log/journal` by default (lost after restart)
- logs can be stored persistently under `/var/log/journal`
- see configuration details: `man 5 journald.conf`
- default config file under `/etc/systemd/jornald.conf`
- `[Journal]` section
    - Storage
        - `auto` (default): `/var/log/journal` if available, `/run/log/journal` otherwise
        - `persistent`: /var/log/journal`
        - `volatile`: `/run/log/journal`
        - `none`: logs dropped
    - `Compress`: `yes` (default), `no`
    - `SystemMaxUse=` (disk), `RuntimeMaxUse=` (RAM): all files combined
    - `SystemMaxFileSize=` (disk), `RuntimeMaxFileSize=` (RAM): each individual file
    - `MaxRetentionSec=`
- `journalctl`: display journal, starting with the oldest entries
    - `-r`: reverse output (newest on top)
    - `-e`: jump to the end of the file
    - `-n [number]`: display `number` lines
    - `-f`: follow (like `tail -f`)
    - `-u [unit]`: show log entries for a specific unit
    - `-o [format]`: use a special output format
        - `verbose`: all fields stored in data base
        - `json-pretty`: JSON format
        - see `man 7 systemd.journal-fields` for details
    - `-x`: enrich output with explanations from catalog, if available
    - `-k`: only display kernel log messages
    - `-b`: only show messages from the current boot
    - `-b -[boot]`: show messages from a specific boot
        - run `journalctl --list-boots` to get the indicator number
    - `--since`/`--until`: specify time frame for the logs to be shown
    - `--disk-usage`: show how much disk space the logs take up
    - `--rotate`: rotate the log files

### Target Units

- target unit files bring the system into a new state, comparable to run levels
- `multi-user.target`: typical for a server system (like run level 3)
- `graphical.target`: typical for a desktop computer (like run level 5)
- `rescue.target`: basic system, mounts, rescue shell (like run level 1)
- `basic.target`: basic system during boot process (before `default.target`)
- `sysinit.target`: system initialization
- see `man 5 systemd.target` and `man 7 systemd.special` for reference
- useful commands for targets:
    - `systemctl list-unit-files -t target`: list `.target` unit files
    - `systemctl list-units -t target`: list target units
    - `systemctl get-default`: display default target
    - `systemctl set-default [default`: set default target
    - `systemctl isolate [target]`: change to a different target
        `systemctl isolate multi-user.target`: changes to tty
        `systemctl isolate graphical.target`: changes to desktop environment
    - `systemctl rescue`: change to rescue shell
    - `systemctl reboot`: reboot the system
    - `systemctl poweroff`: shut the system down
    - `systemctl default`: change to default target (see `systemctl get-default`)

### Containers

- run containers with a full init system
- run containers as a system service
- `systemd-nspawn`: minimalistic container manager
    - originally developed to test systemd without restarting the operating system
- default location for containers: `/var/lib/machines/<container-name>`
    - whole OS file system tree stored therein
- startup a container using `systemd-nspawn -M <container-name>`
    - `-D [dir]`: if containers are stored under different locations
- run `machinectl enable <container-name>` to start the container at system boot
    - `systemctl enable systemd-nspawn@<container-name>` (alternative?)
- run `machinectl start <container-name>` to start the container manually
- get containers using `machinectl pull-raw --verify-checksum <url>`
    - different distros offer additional ways to obtain containers
    - requires dbus (not active by default in Debian)
- some `machinectl` commands:
    - `list`: list containers
    - `login`: login into a container
    - `status`: show the status of a container
    - `reboot`: reboot a container
    - `poweroff`: shut a container down
    - `start`:  start a container up
    - `enable`: start a container up automatically on boot
    - `remove`: delete a container
- set up a container:
    1. `systemd-nspawn [container]`: create the container
    2. `machinectl enable [container]`: start up the container automatically upon next boot
    3. `machinectl start [container]`: start up the container for now
    4. `machinectl login [container]`: start interacting with the container

#### Networking

- `systemd-nspawn`:
    - `--private-network`: loopback only (default)
    - `--network-veth=[device]`: shared ethernet device between host/guest
        - requires `systemd-networkd` to be active
    - `--network-bridge=[device]`: network bridge
    - `--network-interface=[device]`: dedicated, physical hardware interface for container
- configuration: `/etc/systemd/network/`
    - `.network` file: defines a network
    - `.netdev` file: defines a network interface
    - `man 5 systemd.link`
    - `man 5 systemd.netdev`
    - `man 5 systemd.network`

## Summary

- utilities
    - `systemctl (1)`
    - `journalctl (1)`
    - `systemd-cgls (1)`
    - `systemd-cgtop (1)`
    - `timedatectl (1)`
    - `hostnamectl (1)`
    - `systemd-resolve (1)`
    - `systemd-inhibit (1)`
    - `systemd-nspawn (1)`
    - `systemd-cat (1)`
- daemons
    - `init (1)` -> `systemd (1)`
- configuration
    - `systemd.unit (5)`
    - `systemd.service (5)`
    - `systemd.timer (5)`
    - `systemd.path (5)`
    - cgroups: `systemd.resource-control (5)`
    - see `apropos -s 5 systemd`
- more
    - `apropos systemd | grep '^systemd' | wc -l`: 202
- sources, further reading
    - course on Cloud Guru: [Mastering Systemd](https://acloudguru.com/course/mastering-systemd)
    - initial blog post: [Rethinking PID 1](http://0pointer.net/blog/projects/systemd.html)
    - arguments _against_ systemd: [systemd is the best example of Suck.](https://suckless.org/sucks/systemd/)
    - journald: [Ultimate Guide to Logging](https://www.loggly.com/ultimate-guide/using-systemctl/)
