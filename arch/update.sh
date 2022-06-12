#!/bin/bash

cd ~/dotfiles || exit
git fetch && git pull
stow */ --adopt
yay -S --noconfirm "$(grep -v '^#' ~/pkg.list)"
sudo npm i --location=global "$(grep -v '^#' ~/npm.list)" &
nvm install --lts
bob use nightly
