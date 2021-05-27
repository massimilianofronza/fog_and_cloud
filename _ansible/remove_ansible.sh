#!/bin/bash

# Remove everything added by ansible, in opposite order of possible creation

echo "Want to delete instances (y)es/(n)o: "
read servers
echo "Want to delete security group/rules (y)es/(n)o: "
read sec_group
echo "Want to delete networks and routers (y)es/(n)o: "
read networks

# First the instances
if [ "$servers" = "Y" ] || [ "$servers" = "y" ]
then
    servers="n"

    echo ""
    echo "Want to check available instances? (y)es/(n)o"
    read servers
    if [ "$servers" = "Y" ] || [ "$servers" = "y" ]
    then
        servers="n"

        echo "Available servers(wait for it): "
        openstack server list
    fi

    echo "Want to delete load_bal, webserver_* and database? (y)es/(n)o"
    read servers
    if [ "$servers" = "Y" ] || [ "$servers" = "y" ]
    then
        openstack server delete load_bal
        openstack server delete webserver_1
        openstack server delete webserver_2
        openstack server delete database
    fi
fi

# Then the networks
if [ "$networks" = "Y" ] || [ "$networks" = "y" ]
then
    networks="n"
    
    echo ""
    echo "Want to check available networks? (y)es/(n)o"
    read networks
    if [ "$networks" = "Y" ] || [ "$networks" = "y" ]
    then
        network="n"

        echo "Available networks and routers(wait for it): "
        openstack network list
        openstack router list
    fi
    
    echo "Want to delete routerA, routerB, load_net and db_net? (y)es/(n)o"
    read networks
    if [ "$networks" = "Y" ] || [ "$networks" = "y" ]
    then
        openstack router remove subnet routerA load_sub
        openstack router delete routerA		
        openstack router remove subnet routerB load_sub
        openstack router remove subnet routerB db_sub
        openstack router delete routerB
        openstack network delete load_net
        openstack network delete db_net
    fi
fi

# Then security groups
if [ "$sec_group" = "Y" ] || [ "$sec_group" = "y" ]
then
    sec_group="n"

    echo ""
    echo "Want to check available security groups? (y)es/(n)o"
    read sec_group
    if [ "$sec_group" = "Y" ] || [ "$sec_group" = "y" ]
    then
        sec_group="n"

        echo "Available security groups(wait for it): "
        openstack security group list
    fi

    echo "want to delete ans_base_sec_group, ans_load_bal_sec_group, ans_web_server_sec_group and ans_database_sec_group? (y)es/(n)o"
    read sec_group    
    if [ "$sec_group" = "Y" ] || [ "$sec_group" = "y" ]
    then
		openstack security group delete ans_base_sec_group
        openstack security group delete ans_load_bal_sec_group
        openstack security group delete ans_web_server_sec_group
        openstack security group delete ans_database_sec_group
    fi
fi

