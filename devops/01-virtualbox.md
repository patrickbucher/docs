# Install VirtualBox

Install VirtualBox with kernel modules:

    # pacman -S virtualbox virtualbox-host-modules-arch

Add user (`paedu`) to group `vboxusers`:

    # usermod -a -G vboxusers paedu

Restart and login again to make the changes apply:

    # shutdown -r now
