# we download archlinux fs from web
cd /tmp
curl -O https://mirrors.kernel.org/archlinux/iso/2015.03.01/archlinux-bootstrap-2015.03.01-x86_64.tar.gz
tar zxf archlinux-bootstrap-2015.03.01-x86_64.tar.gz .

## edit mirrorlist
nano /tmp/root.x86_64/etc/pacman.d/mirrorlist

# we install the script that will be used
wget https://raw.githubusercontent.com/nickmeessen/archlinux-autodedibox/master/autoinstall.sh
mv autoinstall.sh /tmp/root.x86_64/tmp/

# we chroot into temp arch environment
cd /tmp/root.x86_64
cp /etc/resolv.conf etc
mount -t proc /proc proc
mount --rbind /sys sys
mount --rbind /dev dev
mount --rbind /run run
# (assuming /run exists on the system)
chroot /tmp/root.x86_64 /bin/bash

sh /tmp/root.x86_64/tmp/autoinstall.sh
