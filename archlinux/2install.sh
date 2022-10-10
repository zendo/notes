#! /usr/bin/env bash

:<<!
  Intel: pacman -S mesa xf86-video-intel vulkan-intel intel-ucode
  NVIDIA: pacman -S mesa nvidia xf86-video-nouveau nvidia-utils
  AMD: pacman -S mesa xf86-video-ati xf86-video-amdgpu vulkan-radeon amd-ucode
!

# print command before executing, and exit when any command fails
set -xe

hostname=arch
username=iab
password=123

### Time Zone
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc


### Localization
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
echo 'zh_CN.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen
echo 'LANG=zh_CN.UTF-8' > /etc/locale.conf
export LANG=en_US.UTF-8  #先在终端用英文
echo "Localization Done!"
sleep 3


### Host
echo $hostname > /etc/hostname
echo '127.0.0.1  localhost
::1  localhost
127.0.1.1  arch' > /etc/hosts
echo "Host Done!"
sleep 3


### Necessary Apps
pacman -S dhcpcd netctl iw dialog wpa_supplicant networkmanager bind-tools net-tools dosfstools ntfs-3g btrfs-progs os-prober grub sudo vi nano wget curl expac
systemctl enable dhcpcd.service
systemctl enable NetworkManager.service
systemctl enable systemd-timesyncd.service
echo "Wait a seconds"
sleep 3


### grub
grub-install
grub-mkconfig -o /boot/grub/grub.cfg
sleep 3


### User
echo "root:$password" | chpasswd
useradd -m -G wheel iab
echo "$username:$password" | chpasswd

tee -a /etc/sudoers <<EOF

%wheel ALL=(ALL:ALL) ALL
%wheel ALL=(ALL:ALL) NOPASSWD: ALL
%sudo  ALL=(ALL:ALL) ALL
EOF

echo "Next: exit ; reboot"
