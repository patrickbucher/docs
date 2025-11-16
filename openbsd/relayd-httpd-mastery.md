# Introduction

- httpd always runs in a chroot
- CARP allows multiple hosts to share a single IP address
- http won't provide some features, such as Perl-style regular expressions or custom log formats

# Httpd Essentials

The httpd program is located under `/usr/sbin/httpd`, its configuration under `/etc/httpd.conf`, and files are served from `/var/www`.

After the initial process is started with `root` privileges, which are required to bind well-known ports and to read private keys, three worker processes and one logging process are spawned.

An alternative configuration file can be provided using `-f`. A dry run for configuration checking is started using `-n`. Debug mode is started using `-d`, which leaves the terminal attached to see log messages. Verbosity is added using one or multiple `-v` options.

Use `rcctl` to manage the service, e.g. `rcctl enable httpd` to automatically start `httpd` upon system start, `rcctl start httpd` to start `httpd` manually, and `rcctl reload httpd` to reload its config.

## Basic Configuration

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

Multiple `server` definitions of the same name, listening to different IP addresses or ports, are allowed. It's common to serve both HTTP on port 80 and HTTPS on port 443 for the same server name.

The first server definition found in `/etc/httpd.conf` is considered the default server, used as a fallback. By default, files are served from `/var/www/htdocs`.

Most options apply to single server rather than globally.

Configuration files can be included:

```conf
include "/etc/sites/default.conf"
```

It's a common practice to define different sites in a folder `/etc/sites` in their own `.conf` files.

## Directory Structure

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

## Server Options

For the IP address, `*` and `::` can be used to listen to all IPv4 and IPv6 addresses, respectively. Ports can be defined as numbers or names as listened in `/etc/services`.

Alternative names for the same server can be given using the `alias` directive. The `directory index` directive defines the name of the index file:

```conf
server "jokes.paedubucher.ch" {
	alias "funpage.paedubucher.ch"
	listen on $public_ip port 80
	root "/jokes.paedubucher.ch"
	directory index index.htm
}
```

The `directory auto index` setting creates an automatic index page.

With the `gzip-static` option enabled, clients capable of decompression will be served a file with the suffix `.gz`, if available. Generate those as follows from all HTML files:

```plain
# find /var/www/jokes.paedubucher.ch -type f -iname '*.html' -exec gzip -k {} \;
```

Configuration options for the same directive can be combined. The following two lines…

```conf
directory auto index
directory index index.htm
```

… can be merged into a single line:

```conf
directory {auto index, index index.htm}
```

Configurations can be applied to locations matching a certain pattern. This setting will serve files relative to its `/cgi-bin/` location from the server's root:

```conf
location "/cgi-bin/*" {
	root "/"
}
```

## Locations

Locations can be used to overwrite settings:

```conf
directory auto index
location "/files/" {
	directory no auto index
}
```

## MIME Types

MIME types can be defined using a `types` section, mapping a MIME type to various file extensions:

```conf
types {
	text/html	html htm
}
```

Examples are provided in `/usr/share/misc/mime.types`, which can also be included:

```conf
include "/usr/share/misc/mime.types"
```

## Macros

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

## Authentication

Access can be protected using the `htpasswd` mechanism, referring to a `htpasswd` file within the chrooted directory:

```conf
location "/nsfw/*" {
	authenticate with "/htpasswd"
}
```

Use `htpasswd(1)` to generate the `htpasswd` file:

```plain
# htpasswd -I >/var/www/htpasswd
user:topsecret
```

The `htpasswd` file can be extended, as existing entries are updated and new entries appended to the file:

```plain
# htpasswd /var/www/htpasswd user
```

# Httpd Blocks and Redirects

Requests to sites or locations can be denied using the `block` directive. A blank `block` will return the HTTP 403 error, and `block drop` immediately terminates the request (_The connection was reset_).

```conf
location "/special/*" {
	block
}

location "/private/*" {
	block drop
}
```

A server's block can be overwritten using `pass` in a location.

```conf
block
location "/public/*" {
	pass
}
```

Usually, blocks are accompanied by redirects as `block return` directives with a HTTP status code, e.g. 301 for _Moved Permanently_ (for permanent redirects) or 302 for _Found_ (for temporary ones). 307 and 308 have the same purpose, but unlike 301 and 302 do not allow for a change of the request method.

```conf
location "/classified.html" {
	block return 301 "http://www.cia.gov"
}
```

Redirects work for both servers and locations. The following macros are available to define more flexible redirect rules:

- `$SERVER_NAME`: the name of the server
- `$REQUEST_URI`: the client request after the server part
- `$DOCUMENT_URI`: request path without the query string
- `$QUERY_STRING`: request query string (everything after the `?`)
- `$SERVER_ADDR`: the server's IP address
- `$SERVER_PORT`: the server's port number

For the request `http://jokes.paedubucher.ch/search.php?q=category=dadjokes`, the macros will have the following values assigned:

- `$SERVER_NAME`: `jokes.paedubucher.ch`
- `$REQUEST_URI`: `/search.php?q=category=dadjokes`
- `$DOCUMENT_URI`: `/search.php`
- `$QUERY_STRING`: `q=category=dadjokes`

# Glossary

- CARP: network redundancy protocol
- httpd: web server
- pf: OpenBSD's packet filter
- relayd: load balancer
