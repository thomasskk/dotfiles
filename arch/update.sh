#!/bin/bash

cd ~/dotfiles || exit
git fetch && git pull
stow */ --adopt
git reset --hard
xargs -a ~/pkg.list yay -S --noconfirm
xargs -a ~/npm.list sudo npm i --location=global
source ~/.nvm/nvm.sh
nvm install --lts
bob use nightly
