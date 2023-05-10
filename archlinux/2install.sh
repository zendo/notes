#! /usr/bin/env bash

hostname=arch
username=iab
password=123

PS3='Please enter your choice: '

options=(
    "Timezone"
    "Localization"
    "Hosts"
    "Core apps"
    "Grub"
    "Add User"
    "Quit"
)

select opt in "${options[@]}"

do
    case $opt in
        "Timezone")
            ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
            hwclock --systohc
            echo "Timezone done"
            ;;

        "Localization")
            echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
            echo 'zh_CN.UTF-8 UTF-8' >> /etc/locale.gen
            locale-gen

            echo 'LANG=zh_CN.UTF-8' > /etc/locale.conf
            export LANG=en_US.UTF-8  # Using en env
            echo "Localization done"
            ;;

        "Hosts")
            echo $hostname > /etc/hostname
            tee -a /etc/hosts <<EOF
127.0.0.1  localhost
::1  localhost
127.0.1.1  $hostname
EOF
            echo "Hosts done"
            ;;

        "Core apps")
            pacman -S mesa dhcpcd netctl iw dialog wpa_supplicant \
                   networkmanager bind-tools net-tools dosfstools \
                   ntfs-3g btrfs-progs os-prober grub sudo vi nano \
                   wget curl expac zsh
            systemctl enable dhcpcd.service
            systemctl enable NetworkManager.service
            systemctl enable systemd-timesyncd.service
            echo "Apps and services done"
            ;;

        "Grub")
            grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
            grub-mkconfig -o /boot/grub/grub.cfg
            sleep 3
            echo "Grub done"
            ;;

        "Add User")
            echo "root:$password" | chpasswd
            useradd -m -G wheel $username
            echo "$username:$password" | chpasswd
            tee -a /etc/sudoers <<EOF
%wheel  ALL=(ALL:ALL)   NOPASSWD:SETENV: ALL
EOF
            echo "Now exit chroot and reboot!"
            ;;

        "Quit")
            break
            ;;

        *) echo "invalid option $REPLY";;
    esac
done
