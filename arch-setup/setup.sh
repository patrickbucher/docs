#!/usr/bin/bash

set -e

# TODO: set this options
boot_partition='/dev/mmcblk0p1'
lang='en_US.UTF-8'
locale='en_US.UTF-8 UTF-8'
keymap='de_CH-latin1'
hostname='acerbook'

# additional packages
pacman -S iw wpa_supplicant dialog intel-ucode netctl dhcpcd

# locale settings
ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
timedatectl set-ntp true
hwclock --systohc
echo "$locale" >> /etc/locale.gen
locale-gen
echo "LANG=${lang}" > /etc/locale.conf
echo "KEYMAP=${keymap}" > /etc/vconsole.conf

# hostname
echo -n "$hostname" > /etc/hostname

# boot loader
systemd-machine-id-setup
bootctl --path=/boot install

partuuid=$(blkid | grep "$boot_partition" | egrep -o 'PARTUUID="[^"]+"')
partuuid=$(echo "$partuuid" | egrep -o '[a-fA-F0-9-]+')

cat <<EOF >/boot/loader/entries/arch.conf
title   Arch Linux
linux   /vmlinuz-linuz
initrd  /initramfs-linux.img
options root=PARTUUID=${partuuid} rw
EOF

cat <<EOF >/boot/loader/loader.conf
default arch
timeout 0
editor  0
EOF

echo "Perform the following tasks manually:"
echo "- exit the environment:\t exit"
echo "- unmount recursively: \t umount -R /mnt"
echo "- restart the system:  \t shutdown -h now"
echo "- remove the USB media and start the system"
