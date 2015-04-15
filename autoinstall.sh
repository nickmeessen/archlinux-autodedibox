# we setup disk configuration
mkfs.ext2 /dev/sda1
mkfs.ext4 /dev/sda2
mkswap /dev/sda3

# we mount /dev/sda into our chroot/mnt folder
mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/sda3

# we fix pacman keys
haveged -w 1024
pacman-key --init
pacman-key --populate archlinux
pkill haveged

# we install archlinux to disk
pacstrap /mnt base base-devel syslinux zsh openssh
genfstab -U -p /mnt >> /mnt/etc/fstab

# we get the script that will be used next
wget https://raw.githubusercontent.com/nickmeessen/archlinux-autodedibox/master/autoconfigure.sh
mv autoconfigure.sh /mnt/tmp/

# we chroot into temp arch environment
cd /mnt
cp /etc/resolv.conf etc
mount -t proc /proc proc
mount --rbind /sys sys
mount --rbind /dev dev
mount --rbind /run run
# (assuming /run exists on the system)
chroot /mnt /bin/bash

sh /mnt/tmp/autoconfigure.sh
