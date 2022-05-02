# Unix Package Management

This is a table of commonly used package management commands for the Unix-like
operating systems I use.


| Action                     | Arch Linux                                | Debian GNU/Linux        | Red Hat Linux | Alpine Linux | FreeBSD (System)         | FreeBSD (Ports) | OpenBSD              |
|----------------------------|-------------------------------------------|-------------------------|---------------|--------------|--------------------------|-----------------|----------------------|
| List Available Packages    | `pacman -Sl`                              | `apt list`              |               |              |                          |                 |                      |
| List Installed Packages    | `pacman -Q`                               | `dpkg -l`               |               |              |                          |                 | `pkg_info`           |
| Search Package             | `pacman -Ss [name]`                       | `apt search [name]`     |               |              |                          |                 | `pkg_info -Q [name]` |
| Show Package Details       | `pacman -Qi [name]`                       | `apt show [name]`       |               |              |                          |                 |
| Install Package            | `pacman -S [name]`                        | `apt install [name]`    |               |              |                          |                 | `pkg_add [name]`     |
| Update Package Index       | `pacman -Sy`                              | `apt update`            | `yum update`  |              | `freebsd-update fetch`   |                 |
| Upgrade Packages           | `pacman -Su`                              | `apt upgrade`           | `yum upgrade` |              | `freebsd-update install` | `pkg upgrade`   | `pkg_add -u`         |
| Remove Package             | `pacman -R [name]`                        | `apt remove [name]`     |               |              |                          |                 | `pkg_delete [name]`  |
| Remove with Dependencies   | `pacman -Rs [name]`                       | `apt autoremove [name]` |               |              |                          |                 | `pkg_delete [name]`  |
| Find Package by File       | `pacman -F [file]` or `pacman -Qo [file]` | `dpkg -S [name]`        |               |              |                          |                 |                      |
| List Package Files         | `pacman -Ql [name]`                       | `dpkg -L [name]`        |               |              |                          |                 | `pkg_info -L [name]` |
| Remove Unused Dependencies | n/a                                       | `apt autoremove`        |               |              |                          |                 | `pkg_delete -a`      |
| Cleanup Cache              | `pacman -Sc`                              | `apt autoclean`         |               |              |                          |                 |                      |
| Consistency Check          | `pacman -Dk`                              | n/a                     |               |              |                          |                 |                      |
