# Shared Libraries

- soname: Name eines shared objects
	- libpthread.so.0 (dynamisch gelinkt)
	- libpthread.a (statisch gelinkt)
- Speicherorte
	- /lib
	- /lib32
	- /lib64
	- /usr/lib
	- /usr/local/lib
- Auflösung der Referenzen zur Laufzeit durch ld.so oder ld-linux.so
	- Pfade in /etc/ld.so.conf bzw. /etc/ld.so.conf.d/ konfiguriert
	- ldconfig: liest Konfigurationsdateien, aktualisiert Cache in /etc/ld.so.cache (Versionen)
		- sudo ldconfig -v (verbose)
		- sudo ldconfig -p (print cache)
	- neue Pfade temporär mit `LD_LIBRARY_PATH` definierbar (vgl. `PATH` für Syntax)
- ldd
	- Gelinkte Bibliotheken eines Binaries anzeigen: ldd `which git`
		- ungenutzte Abhängigkeiten: `ldd -u `which git``
	- Gelinkte Bibliotheken einer Library anzeigen: ldd `/lib/x86_64-linux-gnu/libz.so.1

# Geführte Übungen

## 1

linux-vdso.so.1:	linux-vdso	.so.1	1
libprocps.so.6:		procps		.so.6	6
libdl.so.2:		dl		.so.2	2
libc.so.6		c		.so.6	6
ld-linux-x86-64.so.2	ld-linux-x86-64	.so.2	2

## 2

- /etc/ld.so.conf.d/
- sudo ldconfig

## 3

ldd `which kill`

# Offene Übungen

## 1

	$ sudo ldconfig -p | grep libc.so
	libc.so.6 (libc6,x86-64) => /lib/x86_64-linux-gnu/libc.so.6
	$ objdump -p  /lib/x86_64-linux-gnu/libc.so.6
	libc.so.6
	Version References:
	  required from ld-linux-x86-64.so.2:
	    0x09691a75 0x00 42 GLIBC_2.2.5
	    0x0d696913 0x00 41 GLIBC_2.3
	    0x0963cf85 0x00 40 GLIBC_PRIVATE

	$ objdump `which bash`
		Version References:
	  required from libtinfo.so.6:
	    0x00574d03 0x00 06 NCURSES6_TINFO_5.0.19991023
	  required from libc.so.6:
	    0x06969185 0x00 14 GLIBC_2.25
	    0x06969191 0x00 13 GLIBC_2.11
	    0x06969194 0x00 12 GLIBC_2.14
	    0x0d696918 0x00 11 GLIBC_2.8
	    0x069691b3 0x00 10 GLIBC_2.33
	    0x06969195 0x00 09 GLIBC_2.15
	    0x069691b6 0x00 08 GLIBC_2.36
	    0x0d696914 0x00 07 GLIBC_2.4
	    0x069691b4 0x00 05 GLIBC_2.34
	    0x09691974 0x00 04 GLIBC_2.3.4
	    0x0d696913 0x00 03 GLIBC_2.3
	    0x09691a75 0x00 02 GLIBC_2.2.5
