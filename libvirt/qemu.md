# qemu

```sh
apk add qemu-system-x86_64 qemu-img dbus libvirt libvirt-client libvirt-qemu

rc-update add libvirtd
rc-update add dbus
addgroup paedu libvirt kvm
modprobe kvm

wget http://dl-cdn.alpinelinux.org/alpine/v3.8/releases/x86_64/alpine-virt-3.8.2-x86_64.iso
qemu-img create -f raw alpine.qcow 8G
qemu-system-x86_64 -enable-kvm -nographic \
	-m 1024 -boot d -net nic -net user -hda alpine.qcow \
	-cdrom alpine-virt-3.8.2-x86_64.iso 
```
