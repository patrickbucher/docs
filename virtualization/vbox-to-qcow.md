List VMs on Windows:

    VBoxManage.exe list vms

Export VM called "proxmox":

    VBoxManage.exe export proxmox -o proxmox.ova --ovf10

Copy `proxmox.ova` to Linux

    scp proxmox.ova debian@REMOTE-HOST:/home/debian/images/

Unpack the VirtualBox image there:

    tar -xvf proxmox.ova

Convert to QCOW2:

    qemu-img convert -f vmdk -O qcow2 proxmox-disk001.vmdk proxmox.qcow2

[Source](https://linuxconfig.org/converting-virtualbox-ova-to-qcow2-for-qemu-kvm-deployment)
