# Most Relevant

- view/edit network configuration
    - Linux: `ip`
    - BSD: `ifconfig`
- view network connections
    - `netstat` and `ss`
- view open files
    - `lsof`
- view/edit routing configuration
    - `route`
- view network traffic
    - `tcpdump`
- send network traffic
    - `netcat`
- view DNS information
    - `host`

# Overview

| Tool            | Platform | Purpose                        |
|-----------------|----------|--------------------------------|
| `ifconfig`      | BSD      | host network configuration     |
| `ip`            | Linux    |                                |
| `netstat`/`ss`  | Unix     | display network connections    |
| `lsof`          | Unix     | list open files                |
| `netstat`       | Windows  |                                |
| `route`         | Unix     | display/set routing rules      |
| `tcpdump`       | Unix     | display traffic from/to server |
| `netcat`/`ncat` | Unix     | send arbitrary network traffic |
| `traceroute`    | Unix     | show route of traffic          |
| `tracert`       | Windows  |                                |
| `host`          | Unix     | DNS lookup                     |

# Extended

- network configuration
    - `ifconfig`
        - OpenBSD
        - FreeBSD
        - Linux (old)
    - `ip`
        - Linux (new)
    - `ethtool`
        - Linux
- network connections
    - `netstat`
        - OpenBSD
        - FreeBSD
    - `lsof`
        - Linux
        - FreeBSD
    - `fstat` 
        - OpenBSD
    - `ping`
        - OpenBSD
        - FreeBSD
        - Linux
- analyze traffic
    - `netcat`
        - Linux
        - FreeBSD
    - `netstat`
        - OpenBSD
        - FreeBSD
        - Linux
    - `traceroute`
        - OpenBSD
        - FreeBSD
        - Linux
    - `host`
        - OpenBSD
        - FreeBSD
        - Linux
    - `nslookup`
        - OpenBSD
        - Linux
    - `dig`
        - OpenBSD
        - Linux
    - `drill`
        - OpenBSD
        - Linux
    - `tcpdump`
        - OpenBSD
        - FreeBSD
        - Linux
    - `wireshark`
        - OpenBSD
        - FreeBSD
        - Linux
- misc
    - `arp`
        - OpenBSD
        - FreeBSD
        - Linux
