#!/bin/bash -x
# File managed by Ansible
#
# https://www.server-world.info/en/note?os=Ubuntu_24.04&p=ceph
#

#
# RDB = Rados Block Device
#

# create default RBD pool [rbd]
ceph osd pool create rbd 128

# enable Placement Groups auto scale mode
ceph osd pool set rbd pg_autoscale_mode on

# initialize the pool
rbd pool init rbd
ceph osd pool autoscale-status

# create a block device with 12G
rbd create --size 20G --pool rbd rbd01

# show result
rbd ls -l

# map the block device
sudo rbd map rbd01

# show result
rbd showmapped

# format with XFS
sudo mkfs.xfs /dev/rbd0

# mount
sudo mkdir -p /mnt/rbd
sudo mount /dev/rbd0 /mnt/rbd
