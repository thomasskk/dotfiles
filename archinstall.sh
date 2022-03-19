#!/bin/bash

##########################################################################
# INTERNET
##########################################################################
timedatectl set-ntp true

##########################################################################
# DISK
##########################################################################

# Unmount everything
umount -A --recursive /mnt

# Disk selection
echo ""
echo "Select a disk to install on :"
select disk in $(lsblk -n --output TYPE,KNAME,SIZE | awk '$1=="disk"{print"/dev/"$2"|"$3}'); do
	DISK=$(echo "$disk" | awk -F "|" '{print $1}')
	break
done

# Wipe the partition
sgdisk -Z "${DISK}"

# Partition the drive
sgdisk -n 1::+512M -t 1:ef00 -c 1:EFI "$DISK"
sgdisk -n 2::+3G -t 2:8200 -c 2:SWAP "$DISK"
sgdisk -n 3::+15G -t 3:8300 -c 3:ROOT "$DISK"
sgdisk -n 4 -c 4:HOME "$DISK"

# Determine partition name
if [[ "${DISK}" =~ "nvme" ]]; then
	p1=${DISK}p1
	p2=${DISK}p2
	p3=${DISK}p3
	p4=${DISK}p4
else
	p1=${DISK}1
	p2=${DISK}2
	p3=${DISK}3
	p4=${DISK}4
fi

# Format partition
mkfs.fat -F 32 "$p1"
mkswap "$p2"
mkfs.ext4 "$p3"
mkfs.ext4 "$p4"

# Mount partition
mount "$p1" /mnt/boot
swapon "$p2"
mount "$p3" /mnt
mount "$p4" /mnt/home

##########################################################################
# SYSTEM
##########################################################################

# Set mirrors for pacman
reflector -a 12 -f 5 -c 'France' -p https --sort rate --save /etc/pacman.d/mirrorlist

# Install kernel
pacstrap /mnt base linux linux-firmware

genfstab -U /mnt >>/mnt/etc/fstab

# Basic config
loadkeys us
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc --localtime
echo "en_US.UTF-8 UTF-8" >/etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >>/etc/locale.conf

echo "arch" >>/etc/hostname
echo "127.0.0.1 localhost" >>/etc/hosts
echo "::1       localhost" >>/etc/hosts
echo "127.0.1.1 arch.localdomain arch" >>/etc/hosts

pacman -Sy --noconfirm grup dhcpcd

grub-install --target=i386-pc "/dev/${DISK}"
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable dhcpcd.service
systemctl enable sshd

echo root:password | chpasswd
echo thomas:password | chpasswd
echo "thomas ALL=(ALL) ALL" >>/etc/sudoers.d/thomas

exit
reboot
