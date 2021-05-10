#!usr/bin/sh

# Get an ubuntu image
wget / -c https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img

# Create the image
openstack image create --disk-format qcow2 --container-format bare --public \
--file /bionic-server-cloudimg-amd64.img \
ubuntu-bionic-18.04

# Create a custom flavor
openstack flavor create --ram 1024 --disk 5 --vcpus 1 --public mini.ubuntu
