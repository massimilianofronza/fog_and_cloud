#!/bin/bash

# Remove everything added by ansible, in opposite order of creation

# First the instances
openstack server delete ans_load_bal
openstack server delete ans_web_server_1
openstack server delete ans_web_server_2
openstack server delete ans_database

# Then security groups
openstack security group delete ans_load_bal_sec_group
openstack security group delete ans_web_server_sec_group
openstack security group delete ans_database_sec_group
