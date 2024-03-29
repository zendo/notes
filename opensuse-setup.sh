#!/usr/bin/env bash

PS3='Please enter your choice: '

options=(
    "zypper onlyRequires"
    "Mirror sjtu"
    "Packman repo"
    "Codecs"
    "Essential softwares"
    "Development softwares"
    "Gnome"
    "KDE"
    "Quit"
)

select opt in "${options[@]}"

do
    case $opt in
        "zypper onlyRequires")
            sudo bash -c "echo 'solver.onlyRequires = true' >> /etc/zypp/zypp.conf"
            echo "set zypper only require"
            ;;

        "Mirror sjtu")
            sudo zypper mr -da
            sudo zypper ar -fcg https://mirror.sjtu.edu.cn/opensuse/tumbleweed/repo/oss/ sjtu-oss
            sudo zypper ar -fcg https://mirror.sjtu.edu.cn/opensuse/tumbleweed/repo/non-oss/ sjtu-non-oss
            echo "Mirror change to sjtu"
            ;;

        "Packman repo")
            sudo zypper ar -f https://mirrors.bfsu.edu.cn/packman/suse/openSUSE_Tumbleweed/ packman
            sudo zypper dup --from packman --allow-vendor-change
            echo "Add packman repo"
            ;;

        "Codecs")
            sudo zypper in -y ffmpeg gstreamer-plugins-{good,bad,ugly,libav} \
                 libavcodec-full vlc-codecs x264 x265 faac faad2 lame \
                 libxine2 libxine2-codecs ogmtools chromium-ffmpeg-extra \
                 pipewire-aptx
            echo "Install all codecs"
            ;;

        "Essential softwares")
            sudo zypper in -y opi git flatpak \
                 hack-fonts terminus-bitmap-fonts noto-sans-sc-fonts \
                 firewall-config
            echo "Install essential softwares"
            ;;

        "Development softwares")
            sudo zypper in -y patterns-devel-C-C++-devel_C_C++ libopenssl-devel
            echo "Install development softwares"
            ;;

        "Gnome")
            sudo zypper rm -y libreoffice evolution pidgin polari bijiben transmission yelp ibus-table fcitx opensuse-welcome PackageKit
            sudo zypper in -y gnome-font-viewer
            echo "Gnome desktop"
            ;;

        "KDE")
            sudo zypper rm -y plasma5-pk-updates konversation ibus skanlite opensuse-welcome
            sudo zypper in -y gnome-color-manager colord-kde
            echo "KDE desktop"
            ;;

        "Quit")
            break
            ;;

        *) echo "invalid option $REPLY";;
    esac
done
