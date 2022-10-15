#! /usr/bin/env bash

:<<!
简单中文安装脚本：
https://github.com/bianjp/archlinux-installer

复杂通用型安装脚本：
https://github.com/helmuthdu/aui
https://gitee.com/auroot/arch_wiki

station wlan0 get-networks
station wlan0 connect SSID

mkfs.fat -F32
mkfs.btrfs
mkdir -p /mnt/boot/efi
mount
!

# print command before executing, and exit when any command fails
set -xe

### Update the system clock
timedatectl set-ntp true

### Mirror
sed -i "1i Server = https://mirror.sjtu.edu.cn/archlinux/\$repo/os/\$arch" /etc/pacman.d/mirrorlist
sed -i "1i Server = https://mirrors.sustech.edu.cn/archlinux/\$repo/os/\$arch" /etc/pacman.d/mirrorlist

### BootStrap
pacstrap /mnt base base-devel linux-zen linux-firmware efibootmgr bash-completion git

echo "genfstab -U /mnt/boot/efi /mnt >> /mnt/etc/fstab"
echo "Next: cp -r archlinux /mnt/ ; arch-chroot /mnt"
