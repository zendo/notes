#! /usr/bin/env bash
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

# print command before executing, and exit when any command fails
set -xe

### Update the system clock
timedatectl set-ntp true

### Mirror
sed -i "1i Server = https://mirror.sjtu.edu.cn/archlinux/\$repo/os/\$arch" /etc/pacman.d/mirrorlist
sed -i "1i Server = https://mirrors.sustech.edu.cn/archlinux/\$repo/os/\$arch" /etc/pacman.d/mirrorlist

### BootStrap
pacstrap /mnt base base-devel linux linux-firmware efibootmgr bash-completion git
echo "Pacstrap Done!"
sleep 3

cp -r notes/archlinux /mnt/archscripts

genfstab -U /mnt /mnt/boot/efi >> /mnt/etc/fstab

arch-chroot /mnt
