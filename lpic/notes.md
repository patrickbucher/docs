# LPIC-1 (Exam 101)

## 101.1 Determine and Configure Hardware Settings

### Pseudo File Systems

- unlike regular file system:
    - does not exist on a physical disk
    - only exists in RAM
    - use sysfs file system
- `/proc`
    - one pid-named folder by process
        - contains `cmdline`: the command that started the process
    - additional "files" (`cpuinfo`, `uptime`, etc.)
- `/sys`
    - information about current hardware and kernel
    - exposed information for applications for kernel interaction
    - e.g. `fs/xfs` for XFS file systems
        - subfolders `error`, `log`, `stats`

### Working with Kernel Modules

- Linux is a monolithic kernel, but extra functionality (such as drivers) can be
  loaded/unloaded through kernel modules; no re-booting required.
- Linux kernel utilities:
    - `uname`: display info about the running kernel
    - `lsmod`: list modules currently in use
        - output columns: name, memory size, used by modules
    - `modinfo`: display info about a specific module
        - output: filename, license, descriptoin, author, version
    - `modprobe`: load/unload kernel modules
        - unload with `-r` flag

### Investigating Hardware

- D-Bus: messaging bus for hardware and system information
- `udev`: device manager service
    - detects hardware
    - reports detected hardware to D-Bus
    - attaches hardware under the `/dev` pseudo-file system for devices
- `lsblk`: list all block devices (gets info via D-Bus from `/dev`)
- `/dev`: pseudo-file system
    - `/dev/cpu` contains one directory per CPU core (1 to n)
    - `/dev/dri` (direct rendering interface: video card)
    - "files" really are binary streams
- commands pulling information from `/dev`
    - `lspci`: list PCI devices
        - `-k` shows associated kernel modules
    - `lsusb`: list USB devices
        - `-t` shows a tree view (device belonging to controllers)
    - `lscpu`: list CPUs
    - `lsblk`: list block devices
        - `-f` shows file systems contained per device

## 101.2 Boot the System

### The Linux Boot Sequence

- boot process
    - BIOS checks devices
    - boot sector is searched for boot loader
    - boot loader loads the Linux kernel
    - Linux kernel loads the initial RAM disk
    - Linux kernel starts the initialization system
        - initial RAM disk is no longer needed
- boot logs are usually volatile and can be viewed using utilities
    - `dmesg` shows information written to the kernel ring buffer
        - mostly hardware details from the kernel's perspective
    - `journalctl -k` is part of systemd, `-k` shows messages of kernel ring
      buffer
    - both tools show the same information
    - kernel parameters, BIOS information etc. is displayed

### init

- old init is based on Unix System V (sysvinit), starts services sequentially
- located under `/sbin/init`, reads `/etc/inittab`
- based on global runlevels (the system is always in one single runlevel)
    0. halt: to power off the system
    1. single user mode: only root, maintenance
    2. multi user mode (no networking)
    3. multi user mode (with networking)
    4. unused: available for custom use
    5. multi user (with networking and GUI)
    6. reboot: to restart the system (complete boot sequence)
- each run levels runs scripts to start/stop services
- `/etc/inittab` line structure: `<identifier>:<runlevel>:<action>:<process>`
    - `<identifier>`: identifier, e.g. `id` for "init default"
    - `<runlevel>`: numeric, e.g. 3 (multi user mode with networking)
    - `<action>`: ...
    - `<process>`: ...
- referred scripts located under `/etc/rc.d` (Red Hat) or `/etc/init.d` (Debian)
    - "rc" stands for "run commands"
    - directories `rc.0`, `rc.1`, ..., `rc.6` contain the scripts by runlevel
    - `rc.sysinit` performs initialization tasks
    - `rc.local` performs extra tasks
    - scripts pre-fixed with `Kxy` ("kill", number `xy` like 00, 01) or `Sxy`
      ("start", same ordering)
    - scripts are actually symlinks to other scripts (less duplication)

### upstart

- Ubuntu 6.10 introduced upstart as an alternative to init
    - Red Hat etc. adopted it later
- works asynchronuously, decreases boot time
- event-based; monitors and, if needed, re-starts services
- `/sbin/init` -> startup
    - mountall
    - sysinit -> telinit -> runlevel -> ...
- can react to modifications to a running system (soft- and hardware changes)
    - events trigger jobs, i.e. tasks and services
- lifecycle: waiting -> starting -> running -> stopping -> killed -> post-stop -> waiting
    - respawning <-> running (on problems, max. 10 times)

### systemd

- traditional init systems were based on shell scripts, which spawn a lot of
  processes
- systemd implements most of the functionality using C code
- backward compatibility to System V init scripts mostly maintained, but less
  comfortable
- unit files define services etc.
    - `/usr/lib/systemd/system`: system-wide, do not modify
    - `/etc/systemd/system`: modify here to overwrite system-wide
    - `/run/systemd/system`: current runtime, read-only
    - list using `systemctl list-unit-files`
    - based on INI-like syntax
    - `[Unit]` section
        - `Description=...`
        - `Documentation=man:...`
        - `Requires=basic.target` or `Wants=...`: this unit's dependencies
          dependency
        - `After=...` and `Before=`: ordering
        - see `systemd.unit(5)`
    - print unit file using `systemctl cat [name].unit`
- startup process: `/sbin/init -> ../lib/systemd/systemd` (symlink)

## 101.3 Change Runlevels/Boot Targets and Shutdown or Reboot the System

### Change Your Working Environment: runlevels

- runlevels:
    - 0: halt
    - 1: single user mode
    - 2: multi-user mode (without networking)
    - 3: multi-user mode (with networking)
    - 4: unused
    - 5: multi-user (networking, GUI)
    - 6: reboot
- `runlevel` shows the runlevel
- `telinit [runlevel]` changes the runlevel (only as `root`)
    - `telinit 0` halts the system
    - `telinit 6` reboots the system
- see `/etc/inittab` for default runlevel

### Change Your Working Environment: targets

- target unit: get the system into a new state
- `multi-user.traget`: like runlevel 3
- `graphical.target`: like runlevel 5
- `rescue.target`: like runlevel 1
- `basic.target`: during boot process (before other targets)
- `sysint.target`: system initialization
- see `man 5 systemd.target` and `man 7 systemd.special`
- list target unit files: `systemctl list-unit-files -t target`
- list target units : `systemctl list-units -t target`
- show default target: `systemctl get-default`
- set default target: `systemctl set-default multi-user.target`
- change to target: `systemctl isolate multi-user.target`

# Lektion 1

[Quelle](https://learning.lpi.org/de/learning-materials/101-500/101/101.1/101.1_01/)

Befehle:

- `lspci`: PCI-Geräte anzeigen
    - `-s [address]`: Gerät mit bestimmter Adresse anzeigen
    - `-k`: Kernelmodule zum Gerät auflisten
- `lsusb`: USB-Geräte anzeigen
    - `-s [address]`: Gerät mit bestimmter Adresse anzeigen
    - `-d [id]`: Gerät mit bestimmter ID anzeigen
    - `-t`: Darstellung als Baum
- `lsmod`: Kernel-Module auflisten
- `modprobe`: Kernel-Module verwalten
    - `-r [module]`: Modul Entladen
- TODO: `modinfo`: Beschreibung von Kernel-Modul anzeigen
- `fgrep`: Alias für `grep -F` (Filterung nach fixer Zeichenkette)

Dateien:

- `/etc/modprobe.d`
- `/etc/modprobe.conf`
- `/etc/modprobe.d/blacklist.conf`
- `/etc/modprobe.d/[module_name].conf`

- `/dev`
- `/proc`
- `/sys`

- `/sys/devices/system/cpu/vulnerabilities/meltdown`

# Lektion 2

[Quelle](https://learning.lpi.org/de/learning-materials/101-500/101/101.2/101.2_01/)

- UEFI: Unified Extensible Firmware Interface
- ESP: EFI-System-Partition

- `dmesg`
	- `--clear`: Meldungen löschen
- `journalctl`
	- `--list-boots`: Startvorgänge auflisten
	- `-b`: Initialisierungsnachrichten anzeigen
	- `-b=n`: Initialisierungsnachrichten von Boot `n` anzeigen
