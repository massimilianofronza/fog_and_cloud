sudo apt-get update
sudo apt-get install -y nfs-common 

sudo mkdir -p /data/sharedMusic
sudo mount 10.10.10.65:/mnt/sharedMusic /data/Music