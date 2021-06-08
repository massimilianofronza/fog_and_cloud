#!usr/bin/sh

# Get an ubuntu image
wget https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img

# Create the image
openstack image create --disk-format qcow2 --container-format bare --public \
--file bionic-server-cloudimg-amd64.img \
ubuntu-bionic-18.04

# Create a custom flavor
openstack flavor create --ram 1024 --disk 5 --vcpus 1 --public mini.ubuntu

# Create the machine
openstack server create --flavor mini.ubuntu \
 --image ubuntu-bionic-18.04 --network private \
 --user-data keys-udata.txt \
 server-test
 
# MANUAL steps
openstack floating ip create public 
#take not of it in a variable, e.g. FLOAT_IP
openstack server add floating ip server-test $FLOAT_IP

# Creation of volumes
openstack volume create --size 10 db_volume
openstack server add volume database db_volume
openstack server show database --format json | jq .volumes_attached 
openstack volume list 
openstack volume show db_volume