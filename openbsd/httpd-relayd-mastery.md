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

# Globs and Patterns

For server and location indications, glob wildcards are allowed: `?` to match a single character, and `*` to match zero or more characters. Character classes (as lists or ranges) within square brackets are also allowed, which are case-insensitive, e.g. `[a-z]`. They can be negated as `[!a-z]`. Named character classes, such as `alpha` or `alnum` are _not_ supported.

In order to use Lua patterns, the `match` directive has to be used:

```conf
server match "w+.paedubucher.ch" {
	location match "/w+/" {
	}
}
```

Lua patterns support character classes with a `%` prefix:

- `.`: any character
- `%a`: letters
- `%d`: digits
- `%g`: printable characters (except spaces)
- `%l`: lowercase letters
- `%u`: uppercase letters
- `%w`: alphanumeric characters
- `%c`: control characters
- `%p`: punctuation characters
- `%s`: space characters
- `%x`: hexadecimal digits

Sets can be built from classes, e.g. `[%a%d]` for all letters and digits, or by defining lists (`[aeiou]` for vowels) or ranges (`[a-h]` for letters 'a' to 'h'). Negations are defined as `[^aeiou]` (i.e. no vowels). Escape special characters using `%`, e.g. `[%[]` to match a literal `[`.

The suffixes `*`, `+`, `-`, `?` are supported.

The following wildcards are supported:

- `?`: zero or one characters
- `*`: zero or more characters (greedy)
- `+`: one or more characters (greedy)
- `-`: zero or more characters

Use `^` and `$` as anchors for the beginning and end of a string.

Groups of characters are captured within `()` and referred to by `%1`, `%2`, etc.

```conf
location match '^/(%d%d%d%d)-(%d%d)-(%d%d)/.+$' {
	block return 302 "/article.cgi?y=%1&m=%2&d=%3"
}
```

See `patterns(7)` for more information on Lua patterns.

# Httpd Debugging and Logging

Logs are being written into `/var/www/logs` by default. Activity is logged into `access.log`, errors into `error.log` for all servers by default.

The format of the log messages can be defined on the `server` level using the `log style` directive. The default `common` format looks like this:

```plain
jokes.paedubucher.ch 127.0.0.1 - - [18/Nov/2025:06:31:17 +0100] "GET /index.html HTTP/1.1" 304 0
```

The nowadays wider used `combined` format looks as follows:

```plain
jokes.paedubucher.ch 127.0.0.1 - - [18/Nov/2025:06:33:18 +0100] "GET /index.html HTTP/1.1" 304 0 "" "Mozilla/5.0 (X11; Linux x86_64; rv:144.0) Gecko/20100101 Firefox/144.0"
```

The `forwarded` style is the same as `combined`, but also logs the `X-Forwarded-For` and `X-Forwarded-Port` headers.

Define separate log files for a server using the `log access` and `log error` directive, respectively:

```conf
server "jokes.paedubucher.ch" {
	log style combined
	log access jokes_access
	log error jokes_error
}
```

In order to use sub-directories for logging, the path relative to `/var/www/logs` must be enclosed within quotation marks:

```conf
server "jokes.paedubucher.ch" {
	log style combined
	log access "jokes/access"
	log error "jokes/error"
}
```

Those directories have been created manually!

Logs will be rotated according to the rules in `/etc/newsyslog.conf`, which must be extended for custom log file names and locations.

Logging can be deactivated on the `server` or `location` level using the `no log` directive.

The global log directory can be changed using the `logdir` directive, which can be outside the `chroot` directory of `/var/www`.

Logs can be sent to `syslog` using the `log syslog` directive.

Test the current configuration using `httpd -n`. Define an alternative configuration file using `httpd -f FILE`. Combine those to flags to test a configuration file before it is put into its place. Overwrite macro values using `-D`.

# Dynamic Content and Chroots

FastCGI hands off dynamic content processing to a pool of separate processes. OpenBSD's FastCGI implementation is called `slowcgi(8)`. Enable it by adding the following line to `/etc/rc.conf.local`:

```conf
slowcgi_flags=""
```

Run `slowcgi` in debug mode in the foreground using the `-d` flag, or start it in background:

```plain
# rcctl start slowcgi
```

By default, `slowcgi` listens to a socket at `/var/www/run/slowcgi.sock`, which can be changed using the `-s` flag. Set a custom httpd chroot directory using the `-p` flag.

The following configuration hands off requests to `slowcgi`:

```conf
server "jokes.paedubucher.ch" {
	listen on * port 80
	root "/jokes.paedubucher.ch"

	location "/cgi-bin/*" {
		root "/"
		fastcgi
	}
}
```

The `root` directive makes httpd serving requests to `jokes.paedubucher.ch/cgi-bin/` using the chroot's `/cgi-bin/` directory. The `fastcgi` directive tells httpd to pass the request to a FastCGI server.

The demo application `bgplg` in `/var/www/cgi-bin` makes use of the (statically compiled) binaries in `/var/www/bin`, which are _not_ executable by default. Allow their execution as follows (with setuid):

```plain
# chmod 555 /var/www/cgi-bin/bgplg
# chmod 4555 /var/www/bin/ping*
# chmod 4555 /var/www/bin/traceroute*
```

The files must not be owned by the `www` user. Now the sample application _BGPD Looking Glass_ is available under `http://jokes.paedubucher.ch/cgi-bin/bgplg`.

Create a custom Perl script in `/var/www/cgi-bin/foo.pl`:

```perl
#!/usr/bin/perl

print "Content-type: text/html\n\n";
print "<h1>Hello, World!</h1>\n";
```

In order to run this script over the web, copy the `perl` interpreter and all the libraries it depends on into the chroot:

```plain
$ which perl
/usr/bin/perl
# mkdir -p /var/www/usr/bin
# cp `which perl` /var/www/usr/bin/
$ ldd `which perl` | awk '{ print $7 }' | grep 'lib'
/usr/lib/libperl.so.26.0
/usr/lib/libm.so.10.1
/usr/lib/libc.so.102.0
/usr/libexec/ld.so
# mkdir -p /var/www/usr/lib
# mkdir -p /var/www/usr/libexec
# cp /usr/lib/libperl.so.26.0 /var/www/usr/lib/
# cp /usr/lib/libm.so.10.1 /var/www/usr/lib/
# cp /usr/lib/libc.so.102.0 /var/www/usr/lib/
# cp /usr/libexec/ld.so /var/www/usr/libexec/
```

Those binaries must be updated manually after a system/package update.

The script under `http://jokes.paedubucher.ch/cgi-bin/foo.pl` should now output "Hello, World!".

If this doesn't work, test it manually using `chroot`:

```plain
# chroot /var/www/ /cgi-bin/foo.pl
```

A statically linked shell such as `/bin/sh` can be copied into the chroot environment for testing purposes, but shall be removed thereafter for security reasons.

For a PHP/MySQL setup, install the following packages:

```plain
# pkg_add mariadb-server php-curl php-mysqli
```

TODO: p. 66

# Glossary

- CARP: network redundancy protocol
- httpd: web server
- pf: OpenBSD's packet filter
- relayd: load balancer
