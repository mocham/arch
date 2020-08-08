#! /usr/bin/bash

if [ -n $(ls /dev | grep sda1) ]; then
    echo "n
p
1

w" | fdisk /dev/sda
    mkfs.ext4 /dev/sda1
    mount /dev/sda1 /mnt
    pacstrap /mnt linux base networkmanager i3-wm conky grub xorg-xinit xorg-server which ttf-droid ttf-font-awesome ttf-inconsolata rsync
    genfstab /mnt >> /mnt/etc/fstab
    arch-chroot /mnt bash -c "systemctl enable NetworkManager
mkinitcpio -P
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
mkdir -p /home/lz/.config/i3
mkdir -p /home/lz/.config/spacefm
cp -R -T bashscript /home/lz/bashscript
cp -R -T vimfiles /usr/share/vim/vimfiles
cp -T bashscript/vimrc_ /home/lz/.vimrc
cp -T bashscript/gvimrc_ /home/lz/.gvimrc
cp -T bashscript/bashrc_ /home/lz/.bashrc
cp -T bashscript/bash_profile /home/lz/.bash_profile
cp -T bashscript/Xresources /home/lz/.Xresources
cp -T bashscript/i3config /home/lz/.config/i3/config
cp -T bashscript/spacefm-session /home/lz/.config/i3/spacefm/session
cp -T bashscript/spacefm-session /home/lz/.config/i3/spacefm/session-last
cp -T bashscript/spacefm-session /home/lz/.config/i3/spacefm/session-prior
echo 'AQCnataF1
AQCnataF1' | passwd
useradd lz
echo 'x
x' | passwd lz"
fi
