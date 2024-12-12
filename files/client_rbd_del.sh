#!/bin/bash -x
# File managed by Ansible
#
# https://www.server-world.info/en/note?os=Ubuntu_24.04&p=ceph
#

# 
# RDB = Rados Block Device
#

# umount
sudo umount /mnt/rbd

# unmap
sudo rbd unmap /dev/rbd/rbd/rbd01

# delete block dev /dev/rdb01
rbd rm rbd01 -p rbd

# delete pool 
ceph osd pool delete rbd rbd --yes-i-really-really-mean-it
