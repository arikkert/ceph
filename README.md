playbook documentation
======================

Playbooks for Distributed File System Ceph to Configure Storage Cluster of 3 *Ubuntu 24.04 LTS* nodes 
(tested on Vagrant box https://portal.cloud.hashicorp.com/vagrant/discover/crystax/ubuntu2404/versions/1.0.0)
Also configure a client host for testing

It will:
- check if the hosts fulfill the prereq
- configure sdb on all nodes as ceph storage
- install a user *ceph* on all ceph nodes to administer the cluster
- configure all ceph nodes as OSD server
- configure ceph Admin node as
  - MDS server
  - MGR server
  - MON server
- deploy a ceph client node
- enable and configure Ceph dashboard

Info
----

This implementation uses a Makefile as installation wrapper.  
Just type **make** in the directory where the Makefile is located, to install all dependencies and run the playbook.
The makefile calls tools like **yamllint** and **ansible-lint**.
These tools are only called when found in the search path, so no problem if they are not installed.

Requirements
------------

Deploy host has **make**, **ansible** and **ansible-galaxy** installed.
Target hosts have *Ubuntu 24.04 LTS* installed.
Target ceph server hosts have a 100 GB disk attached as /dev/sdb
Requires root access to target hosts.

Variables
---------

Ansible inventory containing definitions for
3 clusters each with 1 control node and 2 worker nodes.
The playbooks only refer to the group names and never tot the individual hosts (*bla.mydomain*) so you can choose your own names for the actual hostnames.
In this implementation (plybooks) there should be exactly one ceph adminhost.

    [cephadmin]
    ceph01.mydomain

    [cephnonadmin]
    ceph02.mydomain
    ceph03.mydomain

    [ceph:children]
    cephadmin
    cephnonadmin

    [cephclients]
    ceph-client.mydomain

ansible group_vars for group ceph with this content:

    _ansible_distribution: 'Ubuntu'
    _ansible_distribution_major_version: 24
    ceph_user: ceph
    ceph_group: ceph

Other variables:

*domain*    # the domain of the used hosts, here *mydomain*

*timezone*  # the timezone on ceph servers and client, e.g. *Europe/Amsterdam*

*files/password.txt* contains the dashboard password I choosed.
I used `ansible-vault` to encrypt it.
Just replace it by your own password, `ansible-vault` encrypted or plain txt

Testing
-------

use installed scripts on the test host in the ansible home dir 

Dependencies
------------

License
-------

BSD

Author Information
------------------

    ARK-ICT
    Andre Rikkert de Koe - ICT
