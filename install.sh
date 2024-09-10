#!/bin/bash

set -e

# This script installs homebrew and .dotfiles using bash
# Homebrew script install.
if ! command -v brew &> /dev/null ; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Check for install in a couple locations:
LINUXBREW_LOC="/home/linuxbrew/.linuxbrew/bin/brew"
MACBREW_LOC="/TODO_NEED_THIS_PATH"
if [ -f $LINUXBREW_LOC ]; then
    HOMEBREW_BIN=$LINUXBREW_LOC
elif [ -f $MACBREW_LOC ]; then
    HOMEBREW_BIN=$MACBREW_LOC
else
    echo "Can't find the binary :["

    # Uninstall
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
    exit 1
fi

packages="wget stow pipx pyenv neovim zsh find gcc rust"

for package in $packages; do
    $HOMEBREW_BIN install $package
done

# Install the dotfiles where they need to go.
for directory in */; do
    stow $directory --adopt
done

# Initialize the homebrew environment.
eval "$($HOMEBREW_BIN shellenv)"

echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >> ~/.zshrc

pipx install poetry
pipx install nox
