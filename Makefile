YAMLLINT=@if which yamllint > /dev/null; then yamllint $@.yml; fi
ANSIBLELINT=@if which ansible-lint > /dev/null; then ansible-lint $@.yml; fi
OPTIONS=--diff #--check
PLAYBOOK=ansible-playbook $(OPTIONS) $@.yml

all: check_vms common main_ceph_part01 main_ceph_part02 common2 main_cephclient cephfs_add dashboard

check_vms common main_ceph_part01 main_ceph_part02 common2 main_cephclient cephfs_add dashboard:
	$(YAMLLINT)
	$(ANSIBLELINT)
	$(PLAYBOOK)
