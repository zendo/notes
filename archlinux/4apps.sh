#! /usr/bin/env bash

# print command before executing, and exit when any command fails
set -xe

### switch en temp
export LANG=en_us

### Basic
sudo pacman -S wayland libinput adobe-source-han-sans-cn-fonts ttf-hack a52dec libmad man-pages-zh_cn firefox-i18n-zh-cn kitty foot fish
echo "Done"
sleep 3

### Archlinux cn
sudo tee -a /etc/pacman.conf <<EOF

[archlinuxcn]
Server = https://repo.archlinuxcn.org/\$arch
EOF

sudo pacman -Syy && sudo pacman -S --noconfirm archlinuxcn-keyring
sudo pacman -S --noconfirm paru pamac ttf-jetbrains-mono gnome-browser-connector

echo "Arch apps Done!"
sleep 3
