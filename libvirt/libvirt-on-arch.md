# libvirt on Arch Linux

## Virtualization Setup

Install Packages:

    # pacman -S libvirt virt-install virt-viewer qemu \
        dnsmasq dmidecode bridge-utils wget

Activate KVM virtualization:

    # modprobe kvm

Enable and start `libvirtd`:

    # systemctl enable --now libvirtd.service

## Network Setup

Check if there's a network called (`default`):

    # virsh net-list --all

A `default` network should be shown; start it, and do so automatically in the future:

    # virsh net-start default
    # virsh net-autostart default

Make sure that there's a virtual bridge called `virbr0`:

    # brctl show

Make sure that NAT is activated:

    # sysctl -a | grep 'net.ipv4.ip_forward = 1'

TODO: possible iptables issue?

## VM Setup

Create a place for the VMs to be used as the working directory henceforth:

    # mkdir /opt/vms
    # cd /opt/vms

Download a recent Debian netinstall ISO image:

    # wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso

Install the VM (`sudo` is used so that the `virt-viewer` GUI is shown in the user's session):

    $ sudo virt-install \
        --virt-type kvm \
        --name debian \
        --memory 2048 \
        --vcpus=2,maxvcpus=4 \
        --cpu host \
        --cdrom /opt/vms/debian-11.3.0-amd64-netinst.iso \
        --disk /opt/vms/debian.qcow2,size=10,format=qcow2 \
        --network network=default

Perform the basic setup using the installer (pick "SSH server" and "standard system utilities" as options).

## VM Network Configuration

Find out the MAC address of the VM just set up:

    # virsh dumpxml debian | grep -i '<mac'
          <mac address='52:54:00:a3:29:26'/>

Edit the definition of the `default` network:

    # virsh net-edit default

A configuration like the following will show up:

```xml
<network>
  <name>default</name>
  <uuid>e53faae9-5c7f-4a53-be28-ca951bf59461</uuid>
  <forward mode='nat'/>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:fe:54:bd'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>
```

Define a static IP for the VM as follows using the MAC address figured out
before and the first IP of the pre-defined range:

```xml
<host mac='52:54:00:a3:29:26' name='debian' ip='192.168.122.2'/>
```

Add this definition to the `<dhcp>` element, so that it looks like this:

```xml
<network>
  <name>default</name>
  <uuid>e53faae9-5c7f-4a53-be28-ca951bf59461</uuid>
  <forward mode='nat'/>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:fe:54:bd'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
      <host mac='52:54:00:a3:29:26' name='debian' ip='192.168.122.2'/>
    </dhcp>
  </ip>
</network>
```

Save and exit, then restart the network:

    # virsh net-destroy default
    # virsh net-start default

Stop and restart the VM:

    # virsh destroy debian # TODO: or shutdown?
    # virsh --connect qemu:///session start debian

Make sure that the VM is reachable:

    $ ping 192.168.122.2

Then consider adding this IP address to your `/etc/hosts` file:

    # echo '192.168.122.2 debian' >> /etc/hosts

Also consider copying your SSH key to the VM:

    $ ssh-copy-id -i ~/.ssh/id_ed25519 debian

## OpenBSD

The keyboard only works when run with the `--graphics vnc` option on this
particular setup. Also, for the `os-variant`, the older `openbsd7.0` had to be
used, because `openbsd7.1` wasn't provided yet.

    # virt-install --virt-type kvm \
        --name openbsd \
        --memory 1024 \
        --vcpus=2,maxvcpus=4 \
        --cpu host \
        --cdrom /opt/vms/cd71.iso \
        --disk /opt/vms/openbsd.qcow2,size=10,format=qcow2 \
        --network network=default \
        --os-variant=openbsd7.0 \
        --graphics vnc
