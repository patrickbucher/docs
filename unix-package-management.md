# Unix Package Management

| Action                     | Arch                | Debian        | RedHat        | Alpine | FreeBSD (Sys/Ports)                      | OpenBSD              |
|----------------------------|---------------------|---------------|---------------|--------|------------------------------------------|----------------------|
| List Available Packages    | `pacman -Sl`        |               |               |        |                                          |                      |
| List Installed Packages    | `pacman -Q`         |               |               |        |                                          | `pkg_info`           |
| Search Package             | `pacman -Ss [name]  |               |               |        |                                          | `pkg_info -Q [name]` |
| Show Package Details       | `pacman -Qi [name]` |               |               |        |                                          |                      |
| Install Package            | `pacman -S [name]`  |               |               |        |                                          | `pkg_add [name]`     |
| Update Package Index       | `pacman -Sy`        | `apt update`  | `yum update`  |        | `freebsd-update fetch`                   |                      |
| Upgrade Packages           | `pacman -Su`        | `apt upgrade` | `yum upgrade` |        | `freebsd-update install` / `pkg upgrade` | `pkg_add -u`         |
| Remove Package             | `pacman -R [name]`  |               |               |        |                                          | `pkg_delete [name]`  |
| Remove with Dependencies   | `pacman -Rs [name]` |               |               |        |                                          | `pkg_delete [name]`  |
| Find Package by File       | `pacman -F [file]`  |               |               |        |                                          |                      |
| List Package Files         | `pacman -Ql xz`     |               |               |        |                                          | `pkg_info -L [name]` |
| Remove Unused Dependencies | n/a                 |               |               |        |                                          | `pkg_delete -a`      |
| Cleanup Cache              | `pacman -Sc`        |               |               |        |                                          |                      |
| Consistency Check          | `pacman -Dk`        |               |               |        |                                          |                      |
