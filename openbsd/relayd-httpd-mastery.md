# Introduction

- httpd always runs in a chroot
- CARP allows multiple hosts to share a single IP address
- http won't provide some features, such as Perl-style regular expressions or custom log formats

# Httpd Essentials

The httpd program is located under `/usr/sbin/httpd`, its configuration under `/etc/httpd.conf`, and files are served from `/var/www`.

After the initial process is started with `root` privileges, which are required to bind well-known ports and to read private keys, three worker processes and one logging process are spawned.

An alternative configuration file can be provided using `-f`. A dry run for configuration checking is started using `-n`. Debug mode is started using `-d`, which leaves the terminal attached to see log messages. Verbosity is added using one or multiple `-v` options.

Use `rcctl` to manage the service, e.g. `rcctl enable httpd` to automatically start `httpd` upon system start, `rcctl start httpd` to start `httpd` manually, and `rcctl reload httpd` to reload its config.

An example configuration is available under `/etc/examples/httpd.conf`. A minimal configuration looks as follows:

```conf
server "jokes.paedubucher.ch" {
	listen on * port 80
	root "/jokes.paedubucher.ch"
}
```

Accompanied by this entry in `/etc/hosts` for testing:

```plain
127.0.0.1	jokes.paedubucher.ch
```

The `/var/www` directory includes the following sub-directories:

- `acme` for Let's Encrypt certificates
- `bin` programs required for CGI
- `cgi-bin` CGI scripts
- `conf` configuration files within the chroot-environment
- `htdocs` location for default website
- `logs` log files
- `run` sockets for FastCGI

The chroot directory can be changed using the `chroot` directive in the config file:

```conf
chroot "/www"
```

Macros can be defined before any configuration directives, and be used using a `$` prefix (`public_ip`):

```conf
public_ip="127.0.0.1"
server "jokes.paedubucher.ch" {
	listen on $public_ip port 80
	root "/jokes.paedubucher.ch"
}
```

Macros do not expand within quote marks. Macros can also be set via `-D` for testing:

```plain
httpd -dvv -D public_ip=192.168.1.100
```

# Glossary

- CARP: network redundancy protocol
- httpd: web server
- pf: OpenBSD's packet filter
- relayd: load balancer
