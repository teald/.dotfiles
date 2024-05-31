#!/bin/bash

set -e

# This script installs nix and dotfiles using bash.

# Nix install
curl -L https://nixos.org/nix/install | sh

. ~/.nix-profile/etc/profile.d/nix.sh

# Installing packages
nix-env -iA \
	nixpkgs.gcc \
	nixpkgs.git \
	nixpkgs.neovim \
	nixpkgs.antibody \
	nixpkgs.zsh 

# Install dotfiles from local script
SOURCE=${BASH_SOURCE[0]}

# Handles symbolic links
# From: https://stackoverflow.com/a/246128
while [ -L "$SOURCE" ]; do
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE 
done

DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

$DIR/setup_from_clone.sh

# Ensure zsh is a login shell.
command -v zsh | sudo tee -a /etc/shells

sudo chsh -s $(command -v zsh) $USER

# Install NeoVim plugins
nvim --headless +PlugInstall +qall
