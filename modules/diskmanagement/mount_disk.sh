#!/bin/bash
#Gum utility for mounting disks and updating fstab file to persist on boot.
clear

gum style \
  --foreground 37 --border-foreground 69 --border double \
  --align center --width 50 --margin "1 0" --padding "0 2" \
  'Disk Mounting Utility'

prompt() {
  gum style --foreground 69 "$1"
}

input() {
  gum input --placeholder "$1"
}

confirm() {
  gum confirm "$1"
}

prompt "Indentifying file systems.."
disks=$(lsblk -f)
prompt "$disks"

#Create a mount point for the drive
prompt "Create a new directory to mount the disk to your file system"
mount_point=$(input "Enter the name for your mount point directory: ex: games")
sudo mkdir /mnt/"$mount_point"

prompt "fstab example: UUID=af8e4d25-b6e0-4bdb-9efd-58d671863f0b /mnt/games ext4 defaults 0 2"
fstab_input=$(input "Enter the file system UUID, MountPoint, FSType, defaults, 0 2")

#Append to fstab
echo "UUID=$fstab_input" | sudo tee -a /etc/fstab

sudo systemctl daemon-reload

show_fstab=$(cat /etc/fstab)
prompt "Fstab file updated"
prompt "$show_fstab"

prompt "Mounting disks"
sudo mount -a
