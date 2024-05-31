#!/bin/bash

set -e

# This file checks for a valid `stow` instance and
# uses that to create symlinks for the file.
#
# If it doesn't find a stow isntance, it looks for:
# + brew
# + nix
#
# Because those are things I use often. If it doesn't find either, it exits.
# Check for install of GNU stow

if command -v stow &> /dev/null
then
	STOW_FOUND='1'
else
	STOW_FOUND='0'
fi

if [ "$STOW_FOUND" = "1" ]
then
	echo "command \"stow\" was found!"
else
	echo "command \"stow\" not found."
	echo "Checking for a package manager..."
fi

COMMAND="stow"

if [ "$STOW_FOUND" = "1" ]
then
	:
elif command -v nix-shell &> /dev/null
then
	echo "Found nix-shell! Using that..."
	COMMAND= "nix-shell -p stow --run $COMMAND"
else
	echo "Couldn't find an installer, exiting."
	exit 1
fi

# Get the directories in this folder.
FIND_COMMAND="find . -maxdepth 1 -type d ! -name ."
REMOVE_SLASHES="sed -E \"s/\.[\/\\]//g\""
REMOVE_GIT="grep -v \".git\""
STOW_COMMAND="xargs -I {} $COMMAND --verbose {} --target=$HOME"
DRY_COMMAND="$FIND_COMMAND | $REMOVE_SLASHES | $REMOVE_GIT"
FULL_COMMAND="$DRY_COMMAND | $STOW_COMMAND"

echo "The following command will be executed to install"
echo "some dotfiles; does this look right?"
echo "================================================="
echo $FULL_COMMAND
echo "================================================="
echo "These are the selected packages: "

for f in $(eval $DRY_COMMAND)
do
	echo "    + $f"
done

echo "If so, type \"yes\". Otherwise, hit enter (or "
echo "type anything else)."
echo "response"
echo "vvvvvvvv"

RESULT="__NO_RESULT"
read RESULT

if [[ "${RESULT,,}" != "yes" ]]
then
	echo "Exiting..."
	exit
fi

eval "$FULL_COMMAND"
