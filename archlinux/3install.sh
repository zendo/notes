#! /usr/bin/env bash

PS3='Please enter your choice: '

options=(
    "Archlinuxcn repo"
    "Apps"
    "Gnome"
    "KDE"
    "AMD"
    "Intel"
    "NVIDIA"
    "Quit"
)

select opt in "${options[@]}"

do
    case $opt in
        "Archlinuxcn repo")
            export LANG=en_US.UTF-8  # Using en temp
            sudo tee -a /etc/pacman.conf <<EOF
[archlinuxcn]
Server = https://repo.archlinuxcn.org/\$arch
EOF
            echo "Archlinuxcn done"
            ;;

        "Apps")
            sudo pacman -Syy && sudo pacman -S --noconfirm archlinuxcn-keyring
            sudo pacman -S --noconfirm wayland libinput a52dec libmad \
                 adobe-source-han-sans-cn-fonts ttf-hack ttf-jetbrains-mono \
                 man-pages-zh_cn firefox-i18n-zh-cn \
                 kitty fish paru pamac flatpak
            echo "Apps done"
            ;;

        "Gnome")
            sudo pacman -S gnome gnome-tweaks seahorse \
                 gnome-browser-connector gnome-power-manager ibus-libpinyin

            sudo systemctl enable gdm.service

            # docnf instead of home-manager
            # gsettings set org.gnome.desktop.wm.preferences audible-bell false
            # gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
            # gsettings set org.gnome.desktop.peripherals.touchpad click-method "'areas'"
            # gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swapcaps']"
            echo "Gnome done"
            ;;

        "KDE")
            sudo pacman -S plasma plasma-wayland-session \
                 konsole dolphin ark gwenview xdg-desktop-portal \
                 fcitx5-im fcitx5-chinese-addons

            sudo systemctl enable sddm.service

            cd ~ || exit
            mkdir Desktop Documents Downloads Music Pictures Videos

            echo "KDE done"
            ;;

        "AMD")
            sudo pacman -S --noconfirm amd-ucode mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon
            echo "AMD done"
            ;;

        "Intel")
            sudo pacman -S --noconfirm intel-ucode mesa lib32-mesa vulkan-intel lib32-vulkan-intel
            echo "intel done"
            ;;

        "NVIDIA")
            sudo pacman -S --noconfirm nvidia-open nvidia-settings lib32-nvidia-utils
            echo "NVIDIA done"
            ;;

        "Quit")
            break
            ;;

        *) echo "invalid option $REPLY";;
    esac
done
