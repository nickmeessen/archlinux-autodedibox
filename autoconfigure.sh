# hostname
echo "dedibox" >> /etc/hostname

# locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=\"en_US.UTF-8\"" >> /etc/locale.conf
export LANG=en_US.UTF-8
echo "KEYMAP=en-pc" >> /etc/vconsole.conf
locale-gen
ln -s /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime

# mkinitcpio
mkinitcpio -p linux

# syslinux
sed -i -e "s/sda3/sda2/g" /boot/syslinux/syslinux.cfg
syslinux-install_update -iam

# root passwd
passwd

# main user passwd
useradd -g users -m -s /bin/zsh mainuser
passwd mainuser

# openssh & network
systemctl enable sshd.service
systemctl enable dhcpcd.service

# exit & reboot
exit
reboot
