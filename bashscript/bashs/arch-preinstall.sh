pacman-key --init
pacman-key --populate archlinux
genfstab -p /mnt >> /mnt/etc/fstab
pacstrap /mnt base
cp -R /bashscript /mnt
arch-chroot /mnt /bin/bash
