#!/usr/bin/env bash

# change to unstable

sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --update
sudo nixos-rebuild switch --upgrade

# clone repository

cd $HOME
git clone https://github.com/VV01T3K/.dotfiles.git
cd .dotfiles

# enable home manager

sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

nix-channel --update
nix-shell '<home-manager>' -A install

# rebuild system

sudo nixos-rebuild switch --flake .
home-manager switch --flake .

echo "Installation complete. Press any key to reboot."
read -n 1 -s
sudo reboot