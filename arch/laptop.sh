#!/bin/bash

yay -S --noconfirm light

sudo usermod -G video -a thomas
sudo light -N 1
