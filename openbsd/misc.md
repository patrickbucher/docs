# Format USB Stick

    # sh MAKEDEV sd1

    # fdisk -e sd1
    > reinit
    > write
    # disklabel sd1 # find out device, here: /dev/rsd1c
    # newfs /dev/rsd1c

# Mount USB Stick

FAT32:

    mount -t msdos /dev/sd1i /mnt

# Deactivate Bell

    # wsconsctl keyboard.bell.volume=0

# UTF-8 Encoding for W3M

In `~/.profile`:

    LANG=UTF-8
    export LANG

# Basic `doas` Config

In `/etc/doas.conf`:

    permit nopass patrick as root
