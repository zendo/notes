#!/usr/bin/env bash
#PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
HEIGHT=20
WIDTH=90
CHOICE_HEIGHT=4
BACKTITLE="Fedora Setup Util - By Osiris - https://lsass.co.uk"
TITLE="Please Make a selection"
MENU="Please Choose one of the following options:"

#Check to see if Dialog is installed, if not install it
if [ "$(rpm -q dialog 2>/dev/null | grep -c "is not installed")" -eq 1 ]; then
    sudo dnf install -y dialog
fi

OPTIONS=(1 "Debloat System"
         2 "Speeding Up DNF"
         3 "Enabling RPM Fusion"
         4 "Installing Essential Software"
         5 "Enabling Flatpak"
         6 "Using en directories in Gnome"
         7 "Installing Extras"
         8 "Install Nvidia - Install akmod nvidia drivers"
         9 "Disable SElinux - Reboot need"
     10 "Quit")

while [ "$CHOICE -ne 4" ]; do
    CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --nocancel \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
    clear

    case $CHOICE in
        1)  echo "Debloat System"
            sudo dnf remove -y libreoffice-core yelp abrt \
                 gnome-user-docs gnome-boxes gnome-tour \
                 ibus-libzhuyin ibus-hangul ibus-anthy
            notify-send "Debloat System" --expire-time=10
            ;;

        2)  echo "Speeding Up DNF"
            echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
            echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
            #echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf
            notify-send "Your DNF config has now been amended" --expire-time=10
            ;;

        3)  echo "Enabling RPM Fusion"
            # sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
            sudo dnf install -y https://mirrors.ustc.edu.cn/rpmfusion/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.ustc.edu.cn/rpmfusion/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
            sudo dnf install -y @multimedia
            # sudo dnf install -y rpmfusion-free-release-tainted
            # sudo dnf install -y dnf-plugins-core
            notify-send "RPM Fusion Enabled" --expire-time=10
            ;;

        4)  echo "Installing Essential Software"
            sudo dnf install -y gnome-tweaks gnome-extensions-app dconf-editor \
                 jetbrains-mono-fonts fira-code-fonts \
                 p7zip-plugins rpmreaper
            notify-send "Software has been installed" --expire-time=10
            ;;

        5)  echo "Enabling Flatpak"
            sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            sudo flatpak remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub
            notify-send "Flatpak has now been enabled" --expire-time=10
            ;;

        6)  echo "Using en directories in Gnome"
            LC_ALL=C xdg-user-dirs-update --force
            notify-send "Done" --expire-time=10
            ;;

        7)  echo "Installing Extras"
            # sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,ugly-\*,base} gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
            # sudo dnf install -y lame\* --exclude=lame-devel
            sudo dnf copr enable zhullyb/v2rayA -y
            sudo dnf group install -y --with-optional virtualization
            sudo dnf group install -y @"C Development Tools and Libraries"
            notify-send "All done" --expire-time=10
            ;;

        8)  echo "Installing Nvidia Driver Akmod-Nvidia"
            sudo dnf install -y akmod-nvidia
            notify-send "All done" --expire-time=10
            ;;

        9)  echo "Disable SElinux"
            sudo sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
sestatus
            notify-send "All done" --expire-time=10
            ;;

        10)
          exit 0
          ;;
    esac
done
