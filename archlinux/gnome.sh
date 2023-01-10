#! /usr/bin/env bash

# print command before executing, and exit when any command fails
set -xe

### switch en temp
export LANG=en_us

sudo pacman -S gnome gnome-tweaks seahorse gnome-power-manager gnome-browser-connector ibus-libpinyin
echo "Done"
sleep 3

sudo systemctl enable gdm.service

# No bell beep sound
gsettings set org.gnome.desktop.wm.preferences audible-bell false
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.peripherals.touchpad click-method "'areas'"
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swapcaps']"

echo "Gnome Done!"
sleep3
