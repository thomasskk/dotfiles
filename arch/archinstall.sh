#!/bin/bash

##########################################################################
# DISK
##########################################################################

# Disk selection
clear
echo "Select a disk to install on :"
select disk in $(lsblk -n --output TYPE,KNAME,SIZE | awk '$1=="disk"{print"/dev/"$2"|"$3}'); do
	DISK=$(echo "$disk" | awk -F "|" '{print $1}')
	break
done

# Detect if nvme protocol
if [[ "${DISK}" =~ "nvme" ]]; then
	p1="${DISK}p1"
	p2="${DISK}p2"
else
	p1="${DISK}1"
	p2="${DISK}2"
fi

# Partition the drive
sgdisk -Z "${DISK}"
sgdisk -n 1:0:+512M -t 1:ef00 -c 1:EFI "$DISK"
sgdisk -n 2:0:0 -t 2:8304 -c 2:ROOT "$DISK"

# Format partition
mkfs.fat -F32 "$p1"
mkfs.ext4 "$p2"

# Mount partition
mount "$p2" /mnt
mkdir /mnt/boot
mount "$p1" /mnt/boot

##########################################################################
# SYSTEM
##########################################################################

# Set password
check_pass() {
	echo
	read -s -p "Password: " PASSWORD
	echo
	read -s -p "Confirm Password: " PASSCONFIRM
	echo
	if [[ "$PASSWORD" != "$PASSCONFIRM" || "$PASSWORD" = "" ]]; then
		echo "Passwords do not match"
		check_pass
	fi
}
check_pass

# Install kernel
pacstrap /mnt base linux linux-firmware

# Filesystems config

boot_uuid=$(blkid -o export "$p1" | grep UUID | head -1 | awk -F= '{print $2}')
root_uuid=$(blkid -o export "$p2" | grep UUID | head -1 | awk -F= '{print $2}')

cat >/etc/fstab <<EOF
#
# Static information about the file system 
#
# <file system> <dir> 	<type> 	<options>    		<dump>  <pass>
UUID=$root_uuid /     	ext4 	defaults,relatime 	0 	1
UUID=$boot_uuid /boot 	vfat 	defaults,relatime 	0 	2
EOF

##########################################################################
# SYSTEM CONFIG
##########################################################################

arch-chroot /mnt /bin/bash <<-EOF
	# SWAP
	swap() {
	dd if=/dev/zero of=/swapfile bs=1M count=512 status=progress
	chmod 600 /swapfile
	mkswap /swapfile
	swapon /swapfile
	echo "/swapfile none swap defaults 0 0" >>/etc/fstab
	}

	timezone() {
	loadkeys us
	ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
	hwclock --systohc --localtime
	echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen
	locale-gen
	echo "LANG=en_US.UTF-8" >>/etc/locale.conf
	}

	host() {
	echo "arch" >>/etc/hostname
	echo "127.0.0.1 localhost" >>/etc/hosts
	echo "::1       localhost" >>/etc/hosts
	echo "127.0.1.1 arch.localdomain arch" >>/etc/hosts
	}

	swap & timezone & host

	pacman -S --noconfirm mesa sudo base-devel grub efibootmgr openssh util-linux connman iwd

	user() {
	useradd -m thomas
	echo "root:${PASSWORD}" | chpasswd
	echo "thomas:${PASSWORD}" | chpasswd
	echo "thomas ALL=(ALL) ALL" >>/etc/sudoers.d/thomas
	}

	grub() {
	grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --removable
	grub-mkconfig -o /boot/grub/grub.cfg
	}

	ctl() {
	systemctl enable sshd
	systemctl enable fstrim.timer
	systemctl enable connman.service
	systemctl enable iwd.service
	}

	user & grub & ctl
	wait
EOF

reboot
