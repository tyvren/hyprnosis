#!/bin/bash

#Gum utility to write ISO images to disk using coreutils in Arch
clear

gum style \
  --foreground 37 --border-foreground 69 --border double \
  --align center --width 50 --margin "1 0" --padding "0 2" \
  'ISO Image Writer'

prompt() {
  gum style --foreground 69 "$1"
}

prompt "Checking USB drives.."
#drive_names=$(find /dev/disk/by-id/usb-* -printf '%f\n' | sed 's/-part[0-9]\+$//' | sort -u)
info=$(ls -l /dev/disk/by-id/usb-*)

readarray -t drives < <(echo "$info" | grep "/dev/disk/by-id/usb-*" | awk '{print $9}' | sed 's/-part[0-9]\+$//')
readarray -t drive_info < <(echo "$info" | awk '{print $11}')

if [ "${drives[$i]}" ]; then
  prompt "Drives found"

  drive_list=()
  for i in "${!drives[@]}"; do
    drive_list+=("${drives[$i]} - ${drive_info[$i]}")
  done

  for i in "${!drive_list[@]}"; do
    prompt "${drive_list[$i]}"
  done

  if gum confirm "Press enter to continue."; then
    prompt "Choose the USB drive to image. (sda/sdb are the top level and overwrites entire disk. sda1,sdb1,sda2 etc.. are partitions)"
    drive_choice=$(printf "%s\n" "${drive_list[@]}" | gum choose --limit=1)
    #Grab the drive name (sdb/sda)
    selection_name=$(echo "$drive_choice" | awk '{print $3}')
    #Remove the ../../ from the output
    selection_mod=${selection_name: -3}
    #Grab the device name for later
    drive_name=$(echo "$drive_choice" | awk '{print $1}')
    #Unmount the disk
    prompt "Unmounting disk"
    umount "/dev/$selection_mod"

    #Enter ISO image path
    iso_path=$(gum input --placeholder "Enter the path to your ISO file. ex: /home/user/Downloads/archlinux-version-x86_64.iso")

    #Build cp command using iso_path and drive name
    prompt "Copying ISO image to USB.."
    sudo cp "$iso_path" "$drive_name"

    gum confirm "Your ISO image has written successfully. Press enter to close."
  else
    exit 0
  fi
else
  prompt "No USB drives found"
  exit 1
fi
