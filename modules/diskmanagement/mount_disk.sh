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

prompt "Indentifying file systems:"
disks=$(lsblk -f)
prompt "$disks"

prompt "Create a new directory or enter an existing directory to mount the disk."
mount_point=$(input "Enter the name of your mount point directory: ex: games")
current_dirs=$(ls /mnt/)

if [[ "$current_dirs" == *"$mount_point"* ]]; then
  prompt "Mount point already exists. Using existing directory."
  chosen_mnt="/mnt/$mount_point"
else
  prompt "Creating new mount point."
  sudo mkdir /mnt/"$mount_point"
  chosen_mnt="/mnt/$mount_point"
fi

disks_filtered=$(lsblk -n -o NAME,UUID,MOUNTPOINT,FSTYPE | grep -v '^zram')
mapfile -t choices <<<"$disks_filtered"
prompt "Select the disk to mount:"
disk_choice=$(printf "%s\n" "${choices[@]}" | gum choose --limit=1)
uuid=$(echo "$disk_choice" | awk '{print $2}')
fstype=$(echo "$disk_choice" | awk '{print $4}')
#fstab example: UUID=af8e4d25-b6e0-4bdb-9efd-58d671863f0b /mnt/games ext4 defaults 0 2

#Check if disk already exists in fstab
fstab_contents=$(</etc/fstab)
if [[ $fstab_contents == *"$uuid"* ]]; then
  if confirm "Disk already exists in fstab, would you like to overwrite? Select No to cancel."; then
    prompt "Overwriting fstab entry."
    sudo sed -i "s|^UUID=$uuid .*|UUID=$uuid $chosen_mnt $fstype defaults 0 2|" /etc/fstab
  else
    exit 0
  fi
else
  prompt "Disk not found in fstab file, continuing update."
  echo "UUID=$uuid $chosen_mnt $fstype defaults 0 2" | sudo tee -a /etc/fstab
fi

sudo systemctl daemon-reload
show_fstab=$(cat -s /etc/fstab)
prompt "Fstab file updated"
prompt "$show_fstab"

prompt "Mounting disks"
sudo mount -a

confirm "Process complete. Press yes to exit."
