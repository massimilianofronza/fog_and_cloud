#!/bin/bash

# Remove everything added by ansible, in opposite order of possible creation

echo "Want to delete instances (y)es/(n)o: "
read servers
echo "Want to delete security group/rules (y)es/(n)o: "
read sec_group
echo "Want to delete networks (y)es/(n)o: "
read networks

# First the instances
if [ "$servers" = "Y" ] || [ "$servers" = "y" ]
then
    servers="n"

    echo "Want to check available instances? (y)es/(n)o"
    read servers
    if [ "$servers" = "Y" ] || [ "$servers" = "y" ]
    then
        servers="n"

        echo "Available servers(wait for it): "
        openstack server list
    fi

    echo "Want to delete ans_load_bal, ans_web_server_* and ans_database? (y)es/(n)o"
    read servers
    if [ "$servers" = "Y" ] || [ "$servers" = "y" ]
    then
        openstack server delete ans_load_bal
        openstack server delete ans_web_server_1
        openstack server delete ans_web_server_2
        openstack server delete ans_database
    fi
fi

# Then the networks
if [ "$networks" = "Y" ] || [ "$networks" = "y" ]
then
    networks="n"
    
    echo "Want to check available networks? (y)es/(n)o"
    read networks
    if [ "$networks" = "Y" ] || [ "$networks" = "y" ]
    then
        network="n"

        echo "Available networks(wait for it): "
        openstack network list
    fi
    
    echo "Want to delete ans_net_first, ans_net_second and ans_net_third? (y)es/(n)o"
    read networks
    if [ "$networks" = "Y" ] || [ "$networks" = "y" ]
    then
        openstack network delete ans_net_first
        openstack network delete ans_net_second
        openstack network delete ans_net_third
    fi
fi

# Then security groups
if [ "$sec_group" = "Y" ] || [ "$sec_group" = "y" ]
then
    sec_group="n"

    echo "Want to check available security groups? (y)es/(n)o"
    read sec_group
    if [ "$sec_group" = "Y" ] || [ "$sec_group" = "y" ]
    then
        sec_group="n"

        echo "Available security groups(wait for it): "
        openstack security group list
    fi

    echo "want to delete ans_load_bal_sec_group, ans_web_server_sec_group and ans_database_sec_group? (y)es/(n)o"
    read sec_group    
    if [ "$sec_group" = "Y" ] || [ "$sec_group" = "y" ]
    then
        openstack security group delete ans_load_bal_sec_group
        openstack security group delete ans_web_server_sec_group
        openstack security group delete ans_database_sec_group
    fi
fi

