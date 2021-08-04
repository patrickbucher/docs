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

# LPIC-1 (Exam 102)
