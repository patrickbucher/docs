# Problem

The interface `vboxnet0` for communication with VirtualBox VMs isn't set up automatically.

# Solution

Create a new interface file `/etc/netctl/vboxnet0` with the following content:

    Description='VirtualBox ethernet connection'
    Interface=vboxnet0
    Connection=ethernet
    IP=static
    Address=('192.168.101.1/24')
    Gateway=('192.168.101.1')

Enable and start the interface:

    # netctl enable vboxnet0
    # netctl start vboxnet0
