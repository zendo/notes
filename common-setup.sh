#!/usr/bin/env bash

PS3='Please enter your choice: '

options=(
    "Flatpak"
    "Gnome en directories"
    "User Nopasswd"
    "Fcitx5 env"
    "Quit"
)

select opt in "${options[@]}"

do
    case $opt in
        "Flatpak")
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            flatpak remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub
            echo "Flatpak add repo and change to sjtu"
            ;;

        "Gnome en directories")
            LC_ALL=C xdg-user-dirs-update --force
            echo "Setting done"
            ;;

        "User Nopasswd")
            tee -a /etc/sudoers <<EOF
            %wheel  ALL=(ALL:ALL)   NOPASSWD:SETENV: ALL
            # %wheel ALL=(ALL:ALL) ALL
            # %wheel ALL=(ALL:ALL) NOPASSWD: ALL
            # %sudo  ALL=(ALL:ALL) ALL
EOF
            echo "Now exit chroot and reboot!"
            ;;

        "Fcitx5 env")
            sudo tee -a /etc/environment <<EOF
            INPUT_METHOD=fcitx5
            GTK_IM_MODULE=fcitx5
            QT_IM_MODULE=fcitx5
            XMODIFIERS=\@im=fcitx5
            SDL_IM_MODULE=fcitx
EOF
            echo "Setting done"
            ;;

        "Quit")
            break
            ;;

        *) echo "invalid option $REPLY";;
    esac
done
