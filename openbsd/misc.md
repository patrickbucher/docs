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
