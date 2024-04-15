# Filesystem Hierarchy Standard (FHS)

see `hier(7)`

- `/`: root
    - `/bin`: basic binary files for all users
    - `/boot`: files required for booting (initrd, Kernel, bootloader)
    - `/dev`: physical and virtual devices
    - `/etc`: configuration files
    - `/home`: users' data, usually one per user (`/home/USER`)
    - `/lib`: shared libraries
    - `/media`: mountable devices (CD, DVD etc.)
    - `/mnt`: mount point for temporary mounted devices (e.g. flash drives)
    - `/opt`: third-party applications
    - `/root`: the root user's home directory
    - `/run`: run time variables
    - `/sbin`: system binary files
    - `/srv`: files hosted by system (e.g. `/srv/www`, `/srv/ftp`, `/srv/http`)
    - `/tmp`: temporary files
    - `/usr`: files for additional software (read-only for regular users)
    - `/proc`: virtual file system for running processes; sub-folder per `PID`
    - `/var`: variable data (data base, log files, mail boxes, caches)
        - `/var/tmp`: persistent temporary files

## `find(1)`

usage:

    find PATH

parameters:

- `-name PATTERN`: name pattern (case sensitive)
- `-iname PATTERN`: name pattern (case insensitive)
- `-fstype FSTYPE`: file system type (e.g. `exfat`)
- `-user USER`: files owned by `USER`
- `-group GROUP`: files owned by `GROUP`
- `-readable`: files readable for current user
- `-executable:` files executable for current user
- `-perm XXXX`: files with permission `XXXX`, e.g. `0640`
    - `perm -XXXX`: files with _at least_ permission `XXXX`
- `-empty`: empty files and directories
- `-size N`: files of size `N` (in 512 byte blocks)
    - `NX` for different units
        - `k`: kilobytes
        - `M`: megabytes
        - `G`: gigabytes
    - `+`/`-` prefix: at least/at most
- `-amin N`: accessed in the last `N` minutes
- `-cmin N`: attributes modified in the last `N` minutes
- `-mmin N`: content modified in the last `N` minutes
- `-atime N`, `-ctime N`, `-mtime N`: same as above, but in days
    - prefix `+`/`-`: more or less than

## `locate(1)` and `updatedb`

cached version of find (using a data base)

create/update db:

    # updatedb

- config: `/etc/updatedb.conf`
- location: `/var/lib/mlocate.db` (may vary)

look for a file: 

    locate .vimrc

look for a file (case insensitive):

    locate -i vim

look for multiple patterns (and)

    locate jpeg png

only list files that still exist

    locate -e PATTERN

## `type`

for multiple matches:

    type -a vim

only output type (file, bulitin, alias):

    type -t vim

## `whereis`

find binaries

    whereis -b locate

find manpages

    whereis -m locate
