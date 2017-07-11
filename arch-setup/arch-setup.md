# Preparation

Prepare the USB stick:

    dd if=archlinux-2017.07.01-x86_64.iso of=/dev/sdb bs=4096

# Installation

Set Swiss German keyboard layout:

    loadkeys de_CH-latin1

Connect to the WiFi network:

    wifi-menu

Update the system clock:

    timedatectl set-ntp true

## Partitioning

Find the block device (`mmcblk0` in case of the _acer_ laptop's SSD card):

    lsblk

Create the partitions:

    fdisk /dev/mmcblk0

- Create a new empty GPT partition table: `g`
- Create the EFI System Partition: `n`, `+512M`
    - Set the type: `t`, `1` (EFI System)
    - Enter the expert's menu: `x`
    - Toggle the bootable flag: `A`
    - Exit the expert's menu: `r`
- Create the Swap Partition: `n`, `+2G`
    - Set the type: `t`, `19` (Linux swap)
- Create the root Partition: `n`, use all blocks
    - set the type: `t`, `20` (Linux filesystem)
- Save and exit: `w`

Format the root file system:

    mkfs.ext4 /dev/mmcblk0p3

Mount it to `/mnt`:

    mount /dev/mmcblk0p3 /mnt

Create directory for the bootloader:

    mkdir /mnt/boot

Format the boot file system:

    mkfs.fat -F32 /dev/mmcblk0p1

Mount boot partition on it:

    mount /dev/mmcblk0p1 /mnt/boot

Format the swap space file system:

    mkswap /dev/mmcblk0p2

Activate it:

    swapon /dev/mmcblk0p2

Install basic packages:

    pacstrap /mnt base

Generate `fstab`:

    genfstab -U /mnt >> /mnt/etc/fstab

Change root into new system:

    arch-chroot /mnt

Set the time zone:

    ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime

Set the hardware clock:

    hwclock --systohc

Uncomment `en_US.UTF-8 UTF-8` in `/etc/locale.gen` and generate locals:

    locale-gen

Set the `LANG` option in `/etc/locale.conf`:

    LANG=en_US.UTF-8

Set the `KEYMAP` option in `/etc/vconsole.conf`:

    KEYMAP=de_CH-latin1

Set the hostname in `/etc/hostname`

    rumpelkiste

Install `intel-ucode`, `dialog`, `iw` and `wpa_supplicant`:

    pacman -S iw wpa_supplicant dialog intel-ucode

Set the root password:

    passwd

Install `systemd-boot`:

    systemd-machine-id-setup
    bootctl --path=/boot install

Create the startup configuration file under `/boot/loader/entries/arch.conf`:

    title   Arch Linux
    linux   /vmlinuz-linux
    initrd  /initramfs-linux.img
    options root=PARTUUID=[partition UUID] rw

Don't write the PARTUUID within double quotes!

Find out partition UUID:

    blkid | grep mmcblk0p3 | egrep -o 'PARTUUID="(.+[^"])"'

Modify `/boot/loader/loader.conf`:

    default arch
    timeout 0
    editor  0

Create new _initramfs_:

    mkinitcpio -p linux

Leave and umount recursively:

    exit
    umount -R /mnt

Shutdown:

    shutdown -h now

# Configuration

## WiFi

Connect to WiFi and store profile:

    wifi-menu -o

Enable and start the `netctl-auto` service:

    systemctl enable netctl-auto@wlp2s0.service
    systemctl start netctl-auto@wlp2s0.service

## User

Add a user:

    useradd -m paedubucher
    passwd paedubucher

## Font

Install terminus:

    pacman -S terminus-font

Use it as the system's default font in `/etc/vconsole.conf`

    FONT=ter-v16n
