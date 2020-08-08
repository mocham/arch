echo dercat > /etc/hostname
ln -s /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc --utc
useradd -m -g users -G wheel -s /bin/bash linz && passwd linz
pacman -S sudo vim htop b43-fwcutter gdisk make acpi cpupower alsa-utils lm_sensors
cp conf/locale.gen /etc/
cp conf/sudoers /etc/
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
mkinitcpio -p linux
setpci -v -H1 -s 00:01.00 BRIDGE_CONTROL=0
