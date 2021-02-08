# WIP: systemd

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
    - not-portable (Linux-specific due to cgroups)
- widely adopted nowadays
    - Debian: 2014 (Devuan fork)
    - Ubuntu followed (replaced Upstart)
    - most major Linux distributions

### Architecture

- daemons: `systemd`, `journald`, `networkd`
- utilities: `systemctl`, `journalctl`, ...
- core: service, timer, mount
- libraries: dbus-1, libpam
- kernel: cgroups, autofs, kdbus
- process management using cgroups (2006/2007)
    - slices: hierarchical groups of processes get their part of the resources
    - `system.slice`: for system services
    - `user.slice`: for each user
    - `systemd-cgls`, `systemd-cgtop`

### Units

- Unix: everything is a file
- systemd: everything is a unit: `something.[unit]`
    - types: scope, slice, socket, service

TODO: theory

### Journal

TODO: hands on journalctl

### Tools

TODO: hands on systemctl

## Summary

- utilities
    - `systemctl`
    - `journalctl`
    - `systemd-cgls`
    - `systemd-cgtop`
    - `timedatectl`
    - `hostnamectl`
    - `systemd-resolve`
    - `systemd-inhibit`
- man pages
    - cgroups: `systemd.resource-control(5)`
