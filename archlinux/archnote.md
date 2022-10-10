# Network


# 参考链接

简单中文安装脚本：
https://github.com/bianjp/archlinux-installer

复杂通用型安装脚本：
https://github.com/helmuthdu/aui
https://gitee.com/auroot/arch_wiki


# 一些技巧
sudo sed -i '1i Server = https://mirrors.aliyun.com/archlinux/$repo/os/$arch' /etc/pacman.d/mirrorlist

sudo sed -i 's/^# %wheel ALL=(ALL) ALL$/%wheel ALL=(ALL) ALL/' /etc/sudoers
