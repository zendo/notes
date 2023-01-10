#! /usr/bin/env bash

#################################
:<<!
https://arch.icekylin.online/

简单中文安装脚本：
https://github.com/bianjp/archlinux-installer

复杂通用型安装脚本：
https://github.com/helmuthdu/aui
https://gitee.com/auroot/arch_wiki

iwd
station wlan0 get-networks
station wlan0 connect SSID

sudo nmtui

mkfs.fat -F32
mkfs.btrfs
mount
mkdir -p /mnt/boot/efi
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
:<<!
  Intel: pacman -S xf86-video-intel vulkan-intel intel-ucode
  NVIDIA: pacman -S nvidia xf86-video-nouveau nvidia-utils
  AMD: pacman -S amd-ucode
!

pacstrap /mnt base base-devel linux linux-firmware efibootmgr bash-completion git amd-ucode
echo "Pacstrap Done!"
sleep 3

### fstab
genfstab -U /mnt /mnt/boot/efi >> /mnt/etc/fstab


cp -r notes /mnt

arch-chroot /mnt
