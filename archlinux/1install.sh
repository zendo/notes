#! /usr/bin/env bash

#################################
:<<!
https://arch.icekylin.online/

iwctl:
station wlan0 get-networks
station wlan0 connect SSID

sudo nmtui

mkfs.fat -F32
mkfs.btrfs
mount
mkdir /mnt/efi
!
#################################

PS3='Please enter your choice: '

options=(
    "enable NTP"
    "change mirror"
    "BootStrap"
    "fstab"
    "cp notes and chroot"
    "Quit"
)

select opt in "${options[@]}"

do
    case $opt in
        "enable NTP")
            timedatectl set-ntp true
            ;;

        "change mirror")
            sed -i "1i Server = https://mirror.sjtu.edu.cn/archlinux/\$repo/os/\$arch" /etc/pacman.d/mirrorlist
            sed -i "1i Server = https://mirrors.sustech.edu.cn/archlinux/\$repo/os/\$arch" /etc/pacman.d/mirrorlist
            ;;

        "BootStrap")
            pacstrap /mnt base base-devel linux linux-firmware efibootmgr bash-completion git amd-ucode
            ;;

        "fstab")
            genfstab -U /mnt /mnt/efi >> /mnt/etc/fstab
            ;;

        "cp notes and chroot")
            cp -r notes /mnt
            arch-chroot /mnt
            ;;

        "Quit")
            break
            ;;

        *) echo "invalid option $REPLY";;
    esac
done
