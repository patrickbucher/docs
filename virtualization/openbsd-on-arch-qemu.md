Install `qemu` and `libvirt`:

    # pacman -S qemu libvirt

Create a network:

    # TODO

Create an image:

    $ mkdir ~/vms
    $ cd ~/vms
    $ qemu-img create -f qcow openbsd71.img 4G
    $ qemu-system-x86_64 -name openbsd71 -cdrom ~/downloads/cd71.iso openbsd71.img

Get the [cd
image](https://cdn.openbsd.org/pub/OpenBSD/7.1/amd64/cd71.img) from the
[OpenBSD Download Page](https://www.openbsd.org/faq/faq4.html#Download).

Use `mirror.ungleich.ch` (for Switzerland) when asked for an HTTP package source.
