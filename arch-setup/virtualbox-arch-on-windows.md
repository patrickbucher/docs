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

Absolutely make sure to install `dhcpcd` before leaving:

    # pacman -S dhcpcd

## Install Guest Additions

Install the guest additions:

    # pacman -S virtualbox-guest-utils-nox

Load the VirtualBox kernel modules:

    # modprobe -a vboxguest vboxsf

## Shared Folder

Add the user to the `vboxsf` group:

    # usermod -a -G vboxsf patrick

Enable and start the `vboxservice`:

    # systemctl enable --now vboxservice.service

Create a shared folder (via menu):

- Path: `C:\Users\patrick\arch-share`
- Name: `arch-share`
- Mount Automatically: Yes
- Mount Point: `/share`
- Permanent: Yes

The directory `/arch-share` should have been created automatically on the guest.
Make sure it is owned by `vboxsf`:

    # chown -R root:vboxsf /share

Mount the share directory manually:

    # mount -t vboxsf -o gid=vboxsf arch-share /share

Create a convenient symlink and test the share (open
`C:\User\patrick\arch-share\hello.txt` on guest):

    $ ln -s /share $HOME/share
    $ echo 'hello' > $HOME/share/hello.txt

## SSH Port Forwarding

Install, enable, and start `sshd` on guest:

    # pacman -S openssh
    # systemctl enable --now sshd

Configure a port forwarding on VirtualBox:

- Name: ssh
- Protocol: TCP
- Host IP: 0.0.0.0
- Host Port: 2222
- Guest IP: 10.0.2.15 (check on guest)
- Guest Port: 22

Check the SSH connection from the host, and copy the SSH key (both requires to
enter the password—for the last time):

    $ ssh -p 2222 patrick@localhost
    $ ssh-copy-id -p 2222 patrick@localhost
