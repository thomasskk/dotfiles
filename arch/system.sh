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
mkdir -p ~/.cargo/bin
curl -L https://github.com/MordechaiHadad/bob/releases/download/v1.0.1/bob-linux-x86_64.zip | bsdtar -xf- -C ~/.cargo/bin
sudo chmod +x ~/.cargo/bin/bob
~/.cargo/bin/bob use nightly
sudo cpanm -n Neovim::Ext

# root
echo "kernel.unprivileged_userns_clone=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl --system

# node
curl -fsSL https://fnm.vercel.app/install | bash
/usr/bin/fnm install --lts

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
