#!/usr/bin/bash

sudo virt-install \
    --name master \
    --memory 1024 \
    --vcpus=1,maxvcpus=2 \
    --cpu host \
    --cdrom debian-10.4.0-amd64-netinst.iso \
    --disk /opt/vms/master.qcow2,size=8,format=qcow2 \
    --network network=default \
    --virt-type kvm
