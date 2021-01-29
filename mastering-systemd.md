# Mastering systemd (A Cloud Guru)

## Previous Service Management Tools

### The Linux Boot Process

1. BIOS starts.
2. The boot loader seeks the boot sector on the first hard drive.
3. The kernel loads with the initial ramdisk (containing the drivers).
4. The kernel mounts the partisions and runs the init system.

### `init`

- original Unix initialization system
- services start sequentially
    - simple
    - blocking (slow)
- kernel starts `/sbin/init`
- configuration with runlevels in `/etc/inittab`

Runlevels:

- 0: halt
- 1: single user mode (root only)
- 2: multi user mode (no networking)
- 3: multi user mod (networking enabled)
- 4: unused (free for custom use by distributions)
- 5: multi user mode with GUI (and networking)
- 6: reboot

Line syntax in `/etc/inittab`:

    <identifier>:<runlevel>:<action>:<process>

Example (`id` stands for "init default", no process):

    id:3:initdefault:

Example (`si` stands for "system init", no runlevel):

    si::sysinit:/etc/rc.d/rc.sysinit

Initialization of `rc` scripts ("run commands"):

    10:0:wait:/etc/rc.d/rc 0
    11:1:wait:/etc/rc.d/rc 1
    12:2:wait:/etc/rc.d/rc 2
    ...
    16:6:wait:/etc/rc.d/rc 6

Those scripts are located in:

- Red Hat: `/etc/rc.d/`
- Debian: `/etc/init.d/`

Subfolders (for each runlevel):

- `rc0.d/`
- `rc1.d/`
- ...
- `rc6.d/`

The file `rc.local` contains the custom configuration (to be modified by the
system administrator). The scripts are symlinks to the original `rc` script
with special parameters.

The scripts have prefixes:

- `S`: start
- `K`: kill

Runlevel 6 (reboot) requires services to be killed.

The prefix is followed by a number (`00..99`) for ordering (start/kill sequence).

### Red Hat Service Tools

- `chkconfig`: enable/disable a service
    - `chkconfig --list`: list services
    - `chkconfig --level 3 httpd on`: start the HTTP daemon with runlevel 3
- `service`: `start`, `stop`, `reload`, etc.
- `netsysv`: textual management tool

### Upstart

- Ubuntu replacement (version 6.10)
- later adopted in Red Hat Enterprise Linux, Debian, etc.
- asynchronuous startup; allows services to be started in parallel
- event-based (trigger jobs)
- monitors services, restarts them, if needed
- can respond to hardware changes
- notions of tasks (finishing) and services (remain running)
- discontinued

Startup Process:

1. `/sbin/init` (for the sake of compatibility)
2. `startup (7)` event
    1. `mountall (8)`: mounts the partitions
    2. `telinit (8)`: initializes the terminal
    3. `runlevel (7)`: starts services in `/etc/init/rc.conf`

States (life cycle):

- waiting
- starting
- running <-> respawn
- stopping
- killed
- post-stopped

## systemd Introduction

### The Purpose of systemd

- goal: more dynamic Linux in respect to changes in the environment (hardware, software)
- inspired by launchd (Apple)
- first release in 2010 for Fedora
- upstart still relied on "a before b"-style dependencies
    - dependencies started automatically, no matter if really needed or not
- idea from launchd: listening for all sockets a daemon will listen for; not to the daemon itself
    - all sockets are made avialable at once
    - daemons do not need to create their own sockets, systemd provides them
    - "socket-based activation"
- daemons can be replaced without loosing messages
- unused sockets are being closed
- universal logging framework with persistent log (after reboot)
- faster boot times

### systemd Architecture

- components in different layers:
    - utilities: `systemctl`, `journalctl`, `nspawn`, ...
    - daemons: `systemd`, `journald`, `networkd`, ...
    - core: service, timer, mount, ...
    - libraries: dbus-1, libpam, ...
    - kernel: cgroups, autofs, kdbus, ...
- process management using cgroups
    - grouped processes get part of resources (slices), hierarchical groups
    - two main slices:
        1. `system.slice`: system services (`crond`, ...)
        2. `user.slice`: one per user (desktop, ...)
- scopes: sets of processes having been started by something else
    - `user.slice` -> `user-1000.slice` -> `session-2.scope`
- `systemd-cgls`: tree of slices/scopes
- `systemd-cgtop`: list of resources
- autofs: mounts services as needed
    - auto unmount after 5 minutes of idleness
    - temporary mount
- read `man 5 systemd.resource-control` for further information on cgroup s

### Alternatives to systemd

- controversy
    - replaces well-tested and well-known init
    - not Unix-like, very complex
    - binary log files
    - feature creep
    - not portable, very Linux-specific (cgroups)
- Debian adopted systemd in 2014
    - Ubuntu (downstream) followed
    - Devuan forked off Debian (without systemd)
- OpenRC (2007)
    - dependency-based
    - alongside sysvinit
    - uses cgroups
    - default in Gentoo and Alpine
    - available for Arch, FreeBSD, NetBSD
- GNU Shepherd
    - dynamic service start
- runit
    - portable
    - default on Void Linux
    - 3 runlevels: startup, running, halt
- systemd is the default on most Linux distributions
