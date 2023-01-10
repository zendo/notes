#! /usr/bin/env bash

# print command before executing, and exit when any command fails
set -xe

sudo pacman -S plasma-meta plasma-wayland-session xdg-desktop-portal konsole dolphin ark gwenview fcitx5-im fcitx5-chinese-addons
echo "Done"
sleep 3

sudo systemctl enable sddm.service

sudo tee -a /etc/environment <<EOF

INPUT_METHOD=fcitx5
GTK_IM_MODULE=fcitx5
QT_IM_MODULE=fcitx5
XMODIFIERS=\@im=fcitx5
SDL_IM_MODULE=fcitx
EOF

cd ~ || exit
mkdir Desktop Documents Downloads Music Pictures Videos

echo "KDE Done!"
sleep3
