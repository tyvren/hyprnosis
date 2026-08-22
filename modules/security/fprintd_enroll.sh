#!/bin/bash

clear

header() {
  gum style \
    --foreground 37 --border-foreground 69 --border double \
    --align center --width 50 --margin "1 0" --padding "0 2" \
    'Enroll a fingerprint'
}

prompt() {
  gum style --foreground 69 "$1"
}

#Other fprintd commands -
#fprintd-verify
#fprintd-delete

checkFingerprints=$(fprintd-list $USER)

header

if [[ "$checkFingerprints" == "No devices available" ]]; then
  enrollFingerprint=$(fprintd-enroll)
  prompt "$enrollFingerprint"
else
  prompt "Fingerprint already enrolled."
fi

gum confirm "Fingerprint enrollment complete."

### Expected output -
#found 1 devices
#Device at /net/reactivated/Fprint/Device/0
#Using device /net/reactivated/Fprint/Device/0
#Fingerprints for user tyvren on Goodix MOC Fingerprint Sensor (press):
# - #0: right-index-finger
###
