#!/usr/bin/bash

sudo virt-install \
    --name openbsd \
    --memory 512 \
    --vcpus=1,maxvcpus=2 \
    --cpu host \
    --cdrom install67.iso \
    --disk path=openbsd.qcow2,size=4,format=qcow2 \
    --network network=default \
    --check path_in_use=off \
    --virt-type kvm
