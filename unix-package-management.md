# Unix Package Management

| Action                     | Arch Linux   | Debian GNU/Linux | RedHat Linux  | FreeBSD (System and Ports)               | OpenBSD                 |
|----------------------------|--------------|------------------|---------------|------------------------------------------|-------------------------|
| Update Package Index       | `pacman -Sy` | `apt update`     | `yum update`  | `freebsd-update fetch`                   |                         |
| Upgrade Packages           | `pacman -Su` | `apt upgrade`    | `yum upgrade` | `freebsd-update install` / `pkg upgrade` | `pkg_add -u`            |
| List all Packages          |              |                  |               |                                          |                         |
| List Installed Packages    |              |                  |               |                                          | `pkg_info`              |
| Search a Package           |              |                  |               |                                          | `pkg_info -Q [term]`    |
| Show a Package             |              |                  |               |                                          |                         |
| Install a Package          |              |                  |               |                                          | `pkg_add [package]`     |
| Remove a Package           |              |                  |               |                                          | `pkg_delete [package]`  |
| Show Package Providng File |              |                  |               |                                          |                         |
| List Files of a Package    |              |                  |               |                                          | `pkg_info -L [package]` |
| Remove Unused Dependencies |              |                  |               |                                          | `pkg_delete -a`         |
