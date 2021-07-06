# Virtualization

Install `libvirt`, `qemu`, `dnsmasq` and `ebtables`:

    # pacman -S libvirt qemu dnsmasq ebtables

Add user to `kvm` and `libvirt` group:

    # usermod -a -G kvm,libvirt $(whoami)

Login/logout for new group settings to apply.

Add the line `group = "kvm"` to `/etc/libvirt/qemu.conf` and apply the new settings:

    # newgrp libvirt

Download the [Docker Machine KVM driver](https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-centos7 -o /usr/local/bin/docker-machine-driver-kvm), move it to `/usr/local/bin/docker-machine-driver-kvm` and make it executable:

    # curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-centos7 -o /usr/local/bin/docker-machine-driver-kvm
    # chmod +x /usr/local/bin/docker-machine-driver-kvm

Enable and start `libvirtd`:

    # systemctl enable libvirtd
    # systemctl start libvirtd

Autostart default virtual network:

    # virsh net-start default
    # virsh net-autostart default
