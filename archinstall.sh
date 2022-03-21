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

# Partition the drive
clear
umount -A --recursive /mnt
sgdisk -Z "${DISK}"
sgdisk -n 1:0:+512M -t 1:ef00 -c 1:EFI "$DISK"
sgdisk -n 2:0:0 -t 2:8304 -c 2:ROOT "$DISK"

# Detect if nvme protocol
if [[ "${DISK}" =~ "nvme" ]]; then
	p1="${DISK}p1"
	p2="${DISK}p2"
else
	p1="${DISK}1"
	p2="${DISK}2"
fi

# Format partition
clear
mkfs.fat -F32 "$p1"
mkfs.ext4 "$p2"

# Mount partition
clear
mount "$p2" /mnt
mkdir /mnt/boot
mount "$p1" /mnt/boot

##########################################################################
# SYSTEM
##########################################################################

# Set password
clear
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
clear
pacstrap /mnt base linux linux-firmware

# Filesystems config
clear
genfstab -U /mnt >>/mnt/etc/fstab

arch-chroot /mnt /bin/bash <<-EOF

	dd if=/dev/zero of=/swapfile bs=1M count=512 status=progress
	chmod 600 /swapfile
	mkswap /swapfile
	swapon /swapfile
	echo "/swapfile none swap defaults 0 0">>/etc/fstab

	loadkeys us
	ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
	hwclock --systohc --localtime
	echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen
	locale-gen
	echo "LANG=en_US.UTF-8" >>/etc/locale.conf

	echo "arch" >>/etc/hostname
	echo "127.0.0.1 localhost" >>/etc/hosts
	echo "::1       localhost" >>/etc/hosts
	echo "127.0.1.1 arch.localdomain arch" >>/etc/hosts

	pacman -Syu
	pacman -S --noconfirm reflector 
	reflector -a 12 -f 5 -c "France" -p https --sort rate --save /etc/pacman.d/mirrorlist
	pacman -S --noconfirm sudo zsh zsh-completions go rust rust-analyzer nodejs-lts-gallium gcc npm python-pynvim cpanminus stow docker docker-compose dhcpcd openssh networkmanager iw bspwm dmenu kitty xorg-xinit base-devel git grub dhcpcd networkmanager efibootmgr openssh util-linux libreoffice-still xorg-server sxhkd terminus-font

	useradd -m thomas
	echo "root:${PASSWORD}" | chpasswd
	echo "thomas:${PASSWORD}" | chpasswd
	echo "thomas ALL=(ALL) ALL" >>/etc/sudoers.d/thomas

	cd /tmp
	echo "${PASSWORD}" | sudo -S -u thomas su thomas
	git clone https://aur.archlinux.org/yay.git 
	cd yay
	makepkg -si --noconfirm 
	echo "${PASSWORD}" | sudo -S -u thomas su root

	yay -Syu
	yay -S --noconfirm brave-nightly-bin polybar lazydocker

	curl https://discord.com/api/download?platform=linux&format=tar.gz -L -o /tmp/discord.tar.gz
	tar -xvf /tmp/discord.tar.gz -C ~/.local/bin
	sudo ln -s ~/.local/bin/Discord/discord.png /usr/share/icons/discord.png
	sudo ln -s ~/.local/bin/Discord/Discord /usr/bin

	grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
	grub-mkconfig -o /boot/grub/grub.cfg

	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
	chsh -s /bin/zsh thomas

	curl https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz -L -o /tmp/nvim.tar.gz
	tar xzf /tmp/nvim.tar.gz -C /tmp
	cp -r /tmp/nvim-linux64/* /usr
	cpanm -n Neovim::Ext
	npm i -g eslint yarn prettier typescript pyright neovim

	git clone https://github.com/thomasskk/dotfiles.git /home/thomas/dotfiles
	cd /home/thomas/dotfiles && stow */

	systemctl enable NetworkManager
	systemctl enable dhcpcd.service
	systemctl enable sshd
	systemctl enable reflector.timer
	systemctl enable fstrim.timer
	systemctl enable docker.service

EOF
