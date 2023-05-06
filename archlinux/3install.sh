#! /usr/bin/env bash

PS3='Please enter your choice: '

options=(
    "Archlinuxcn repo"
    "Apps"
    "Gnome"
    "KDE"
    "Gnome en directories"
    "Flatpak"
    "Quit"
)

select opt in "${options[@]}"

do
    case $opt in
        "Archlinuxcn repo")
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
                 kitty fish paru pamac
            echo "Apps done"
            ;;

        "Gnoome")
            sudo pacman -S --noconfirm gnome gnome-tweaks seahorse \
                 gnome-browser-connector gnome-power-manager ibus-libpinyin

            sudo systemctl enable gdm.service

            # docnf
            gsettings set org.gnome.desktop.wm.preferences audible-bell false
            gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
            gsettings set org.gnome.desktop.peripherals.touchpad click-method "'areas'"
            gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swapcaps']"
            echo "Gnome done"
            ;;

        "KDE")
            sudo pacman -S --noconfirm plasma plasma-wayland-session \
                 konsole dolphin ark gwenview xdg-desktop-portal \
                 fcitx5-im fcitx5-chinese-addons

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

            echo "Apps and services done"
            ;;

        "Gnome en directories")
            LC_ALL=C xdg-user-dirs-update --force
            echo "Setting done"
            ;;

        "Flatpak")
            sudo pacman -S --noconfirm flatpak
            sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            sudo flatpak remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub
            echo "Flatpak done"
            ;;

        "Quit")
            break
            ;;

        *) echo "invalid option $REPLY";;
    esac
done
