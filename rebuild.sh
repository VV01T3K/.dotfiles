#!/usr/bin/env bash
cd $HOME/.dotfiles/
sudo nixos-rebuild switch --flake .
home-manager switch --flake .
# nix flake update
# nix-channel --update
