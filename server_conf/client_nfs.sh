sudo apt-get update
sudo apt-get install -y nfs-common 

sudo mkdir -p /data/sharedMusic
sudo mount 10.10.30.205:/mnt/sharedMusic /data/sharedMusic