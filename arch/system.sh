#!/bin/bash

# base pkg
sudo pacman -Syu --noconfirm reflector git stow
sudo reflector -a 12 -f 5 -c "France" -p https --sort rate --save /etc/pacman.d/mirrorlist

# Dotfiles
git clone https://github.com/thomasskk/dotfiles.git ~/dotfiles
cd ~/dotfiles || exit
stow */ --adopt
git reset --hard

# yay
git clone https://aur.archlinux.org/yay.git && cd yay && yes '' | makepkg -si
cd .. && rm -rf yay
yay -Syu

# pkg.list
xargs -a ~/pkg.list yay -S --noconfirm

# nvim
sudo cpanm -n Neovim::Ext

# root
echo "kernel.unprivileged_userns_clone=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl --system

# node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
source ~/.nvm/nvm.sh
nvm install --lts

# npm.list
xargs -a ~/npm.list sudo npm i --location=global

# zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
	~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting &
git clone https://github.com/zsh-users/zsh-autosuggestions \
	~/.oh-my-zsh/custom/plugins/zsh-autosuggestions &

chsh -s /bin/zsh thomas
sudo chown -R thomas:users /home/thomas

# seatd
sudo systemctl enable seatd.service
sudo usermod -G seat -a thomas

# services
sudo systemctl enable \
	reflector.timer \
	docker.service \
	bluetooth \
	cronie

wait
