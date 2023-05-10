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

# print command before executing, and exit when any command fails
set -xe

### NTP
timedatectl set-ntp true

### Mirrors
sed -i "1i Server = https://mirror.sjtu.edu.cn/archlinux/\$repo/os/\$arch" /etc/pacman.d/mirrorlist
sed -i "1i Server = https://mirrors.sustech.edu.cn/archlinux/\$repo/os/\$arch" /etc/pacman.d/mirrorlist


### BootStrap
pacstrap /mnt base base-devel linux linux-firmware efibootmgr bash-completion git amd-ucode
echo "Pacstrap Done!"
sleep 3

### fstab
genfstab -U /mnt /mnt/efi >> /mnt/etc/fstab


cp -r notes /mnt

arch-chroot /mnt
