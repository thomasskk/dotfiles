#!/bin/bash

cd ~/dotfiles || exit
git fetch && git pull
stow */ --adopt
git reset --hard
xargs -a ~/pkg.list yay -S --noconfirm --needed
xargs -a ~/npm.list sudo npm update --location=global
source ~/.nvm/nvm.sh
nvm install --lts
bob use nightly
