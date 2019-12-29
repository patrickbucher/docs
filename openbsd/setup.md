This document describes the installation of OpenBSD 6.6 on a Intel NUC.

# Preparation

Download [install66.fs](https://ftp.openbsd.org/pub/OpenBSD/6.6/amd64/install66.fs) from [FTP](https://ftp.openbsd.org/pub/OpenBSD/6.6/amd64/):

    $ curl https://ftp.openbsd.org/pub/OpenBSD/6.6/amd64/install66.fs > install66.fs

Build the SHA-256 hash and check against the [checksums on FTP](https://ftp.openbsd.org/pub/OpenBSD/6.6/amd64/SHA256):

    $ sha256sum install66.fs

Copy the file system to a USB stick:

    # dd if=install66.fs of=/dev/sdb bs=4M

# Installation

The installation is mostly straightforward according to [INSTALL.amd64](https://ftp.openbsd.org/pub/OpenBSD/6.6/amd64/INSTALL.amd64).

To intall the sets, pick the `http` option and use the hostname `mirror.ungleich.ch`.

Un-select the `x` sets using `-x*`.

# Configuration

On order to use a Swiss German keyboard layout, create a file `/etc/kbdtype` with the following content:

    sg
