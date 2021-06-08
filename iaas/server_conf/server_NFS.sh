#!/bin/sh

# Creation of the Network File System
sudo apt-get update
sudo apt install -y nfs-kernel-server

# Shared folder
sudo mkdir -p /mnt/sharedMusic

# Make it accessible to the clients
sudo chown nobody:nogroup /mnt/sharedMusic
sudo chmod 777 /mnt/sharedMusic

# Assign server access to clients/subnet
# TODO: CHANGE THE SUBNET WHEN THE FINAL ARCHITECTURE IS UP
sudo sed -i '$ a /mnt/sharedMusic 10.10.10.0/24(rw,sync,no_subtree_check)' /etc/exports

# Export the shared directory
sudo exportfs -a

# Restart the nfs server to make changes effective
sudo systemctl restart nfs-kernel-server

echo "Now go to /server_conf/client_nfs.sh"
