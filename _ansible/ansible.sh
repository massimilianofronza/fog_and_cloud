#!/bin/bash

echo "Want to build networks (y)es/(n)o: "
read networks
echo "Want to build security group/rules (y)es/(n)o: "
read sec_group
echo "Want to build instances (y)es/(n)o: "
read servers

if [ "$networks" = "Y" ] || [ "$networks" = "y" ]
then
    # To execute a verbose version and being able to tell which task to execute:
    ansible-playbook -v network_setup.yml --step
fi

if [ "$sec_group" = "Y" ] || [ "$sec_group" = "y" ]
then
    ansible-playbook -v sec_group_setup.yml --step
fi

if [ "$servers" = "Y" ] || [ "$servers" = "y" ]
then
    ansible-playbook -v launch_instances.yml --step
fi

