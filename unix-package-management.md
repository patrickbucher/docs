# Unix Package Management

This is a table of commonly used package management commands for the Unix-like
operating systems I use.


| Action                     | Arch Linux                                | Debian GNU/Linux        | Red Hat Linux           | FreeBSD (System and Ports)                 | OpenBSD              |
|----------------------------|-------------------------------------------|-------------------------|-------------------------|--------------------------------------------|----------------------|
| List Available Packages    | `pacman -Sl`                              | `apt list`              | `yum list --available`  | n/a                                        | n/a                  |
| List Installed Packages    | `pacman -Q`                               | `dpkg -l`               | `yum list --installed`  | `pkg info -a`                              | `pkg_info`           |
| Search Package             | `pacman -Ss [name]`                       | `apt search [name]`     | `yum search [name]`     | `pkg search [name]`                        | `pkg_info -Q [name]` |
| Show Package Details       | `pacman -Qi [name]`                       | `apt show [name]`       | `yum info [name]`       | `pkg info [name]`                          | `pkg_info [name]`    |
| Install Package            | `pacman -S [name]`                        | `apt install [name]`    | `yum install [name]`    | `pkg add [name]`                           | `pkg_add [name]`     |
| Update Package Index       | `pacman -Sy`                              | `apt update`            | `yum update`            | `freebsd-update fetch`                     | n/a                  |
| Upgrade Packages           | `pacman -Su`                              | `apt upgrade`           | `yum upgrade`           | `freebsd-update install` and `pkg upgrade` | `pkg_add -u`         |
| Remove Package             | `pacman -R [name]`                        | `apt remove [name]`     | `yum remove [name]`     | `pkg delete [name]`                        | `pkg_delete [name]`  |
| Remove with Dependencies   | `pacman -Rs [name]`                       | `apt autoremove [name]` | `yum autoremove [name]` | n/a                                        | `pkg_delete [name]`  |
| Find Package by File       | `pacman -F [file]` or `pacman -Qo [file]` | `dpkg -S [file]`        | `yum provides [file]`   | `pkg which [file]`                         | `pkg_info -E [file]` |
| List Package Files         | `pacman -Ql [name]`                       | `dpkg -L [name]`        | `repoquery -l [name]`   | `pkg info -l [name]`                       | `pkg_info -L [name]` |
| Remove Unused Dependencies | n/a                                       | `apt autoremove`        | `yum autoremove`        | `pkg autoremove`                           | `pkg_delete -a`      |
| Cleanup Cache              | `pacman -Sc`                              | `apt autoclean`         | `yum clean all`         | `pkg clean`                                | n/a                  |
| Consistency Check          | `pacman -Dk`                              | n/a                     | `yum check`             | `pkg check`                                | `pkg_check`          |

## Notes

- Arch Linux
    - `pacman -F [file]` works on all packages, but requires the file database
      to be present (`pacman -Fy`). `pacman -Qo [file]` only works for installed
      packages.
- Red Hat Linux
    - The `repoquery` tool is provided by `yum-utils`.
- FreeBSD
    - The `pkg check` command has various flags to check different things.
- OpenBSD
    - Use `syspatch` for security updates.
