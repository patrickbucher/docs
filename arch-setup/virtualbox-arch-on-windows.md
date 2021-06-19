## Arch Linux Guest on Windows VirtualBox Host

## Goal

Setup an Arch Linux guest on a Windows VirtualBox Host with file exchange.

## Starting Situation

The Windows host is setup and has VirtualBox installed.

## Basic Setup

VirtualBox Parameters:

- Name: `arch`
- Memory: 4096 MB
- Disk: VDI, dynamic, 80 GB

Enable EFI for the `arch` VM:

    > VBoxManage modifyvm arch --firmware efi

Follow the
[setup routine](https://github.com/patrickbucher/docs/blob/master/arch-setup/arch-setup.md),
but install GRUB instead:

    # pacman -S grub efibootmgr
    # grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
    # grub-mkconfig -o /boot/grub/grub.cfg

Make sure to install `dhcpcd` before leaving:

    # pacman -S dhcpcd
