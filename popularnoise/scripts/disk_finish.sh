#!/bin/bash
sudo mkfs -t ext4 /dev/xvdg
sudo mkdir /data/
sudo mount /dev/xvdg /data/
sudo echo /dev/xvdg /data/ ext4 defaults 0 0 >> /etc/fstab


# manaul method for attaching the ssd volume to the instance
# after created you will need to shell instance, format the volume with a filesystem and mount it
# sudo mkfs.ext4 /dev/xvdh
# sudo mkdir /data - create a local folder that will be used as the mount point
# sudo mount /dev/xvdh /data
# add the line '/dev/xvdh /data ext4 defaults 0 0' (without quotes) to the /etc/fstab file to auto mount on reboot
