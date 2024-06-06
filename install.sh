#!/bin/bash

set -e

# This script installs nix and dotfiles using bash.

# Old Nix install
# curl -L https://nixos.org/nix/install | sh

# Determinate nix install
# this uses nix-install (https://github.com/DeterminateSystems/nix-installer)
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix \
	| sh -s -- install

NIX_SHELL_PATH="~/.nix-profile/etc/profile.d/nix.sh"
NIX_DAEMON_PATH="/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"

# TODO: This could probably be automated.
if [ -f $NIX_SHELL_PATH ]; then
	echo "Found $NIX_SHELL_PATH"
	. $NIX_SHELL_PATH
elif [ -f $NIX_DAEMON_PATH ]; then
	echo "Found $NIX_DAEMON_PATH"
	. $NIX_DAEMON_PATH
else
	echo "Could not find a nix daemon or profile. Checked: "
	echo "  + $NIX_SHELL_PATH"
	echo "  + $NIX_DAEMON_PATH"
	echo "Exiting..."
	exit 1
fi

echo "Creating install command..."
echo "*********************************************"
SOURCE=${BASH_SOURCE[0]}

install_command() {
	set -e
	echo $(command -v lua)

	# Install dotfiles from local script
# Handles symbolic links # From: https://stackoverflow.com/a/246128
	while [ -L "$SOURCE" ]; do
	  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
	  SOURCE=$(readlink "$SOURCE")
	  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE 
	done

	DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

	$DIR/setup_from_clone.sh

	# Install NeoVim plugins
	nvim --headless +PlugInstall +qall
}

# Serialize the funciton to a string and store it in the installation variable.

DOTFILE_INSTALL_COMMAND="$(declare -f install_command); install_command"

echo $DOTFILE_INSTALL_COMMAND
echo "*********************************************"


# Ensure zsh is a login shell.
echo "Ensuring zsh is the shell used as the login shell."
command -v zsh | sudo tee -a /etc/shells

sudo chsh -s $(command -v zsh) $USER


# Start dev shell
echo "Starting dev shell."
nix-shell ./nix/dev_env.nix --run "$DOTFILE_INSTALL_COMMAND" --pure

# Enter .zshrc or .bashrc env
if [ -f ~/.zshrc ] -a [ comamnd -v zsh ]; then
	echo "Using zsh..."
	source ~/.zshrc
elif [ -f ~/.bashrc ]; then
	echo "Using bash..."
	source ~/.bashrc
else
	echo "COULD NOT START A SHELL: NO RC FILES COUND FOR"
	echo "ZSH OR BASH (~/.zshrc or ~/.bashrc, respectively)."
fi

