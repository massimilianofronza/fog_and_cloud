sudo apt-get update
sudo apt-get install -y nfs-common 

sudo mkdir -p /mnt/sharedMusic
sudo mount 10.10.30.97:/mnt/sharedMusic /mnt/sharedMusic
