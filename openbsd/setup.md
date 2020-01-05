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

To install from disk, escape the setup with `!`.

If the device is not visible under `/dev`, plug the usb stick out and in to see the diagnostics message, revealing the device name (`sd1`, for example). Create a new device:

    # cd /dev
    # sh MAKEDEV sd1

Then mount the partition:

    # mount /dev/sd1a /mnt2

Go back to the installer:

    # exit

The sets will be found now.

Un-select the `x` sets using `-x*`.

# Configuration

On order to use a Swiss German keyboard layout, create a file `/etc/kbdtype` with the following content:

    sg

# WiFi

For WiFi (acer laptop needs iwn-7265-16), the firmware can be downloaded from the [OpenBSD firmware server](http://firmware.openbsd.org/firmware/6.6/iwm-firmware-20190923.tgz) and installed using `fw_update(1)`, assuming that the firmware is in the `firmware` folder on a usb stick mounted on `/mnt`.

    fw_update -p [path to unpacked firmware FOLDER]

Create a file `/etc/hostname.iwm0` (look up device name ‒ here iwm0 ‒ with `ifconfig`):

    dhcp nwid [your ESSID] wpakey [your WPA key]

Restart the networking:

    # sh /etc/netstart iwm0
