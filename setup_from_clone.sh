#!/bin/bash
#
# NOTE this will not install nix, nor is it nix-dependent, but it may move some
# nix files into the home directory.
#
# TODO: Check commands to see if the stow files are needed
#	+ Maybe using some kind of config file in each stowed dir?
#		+ Can stow ignore files in a package?

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
STOW_COMMAND="xargs -I {} $COMMAND --verbose {} --target=$HOME"
DRY_COMMAND="
	find . -maxdepth 1 -type d | 
	sed -E \"s/\.[\/\\]//g\" |
	grep -v \"^.$\" |
	grep -v \".git\" |
	grep -v ".*/?" | 
	grep -v "dotfile_backups""

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

echo "If so, type "yes". Otherwise, hit enter (or"
echo "type anything else)."
echo "response"
echo "vvvvvvvv"

RESULT="__NO_RESULT"
read RESULT

# Force result to be lowercase
RESULT="$(echo $RESULT | tr "[:upper:]" "[:lower:]")"

if [[ "$RESULT" != "yes" ]]
then
	echo "Exiting..."
	exit
fi

# Check if anything needs to be backed up.
# TODO: This would be much better as a script/function that can easily be
# reversed.
DIRS="$(eval $DRY_COMMAND)"
BACKUP_LOC=$(echo "$HOME/.dotfiles_backups/$( date ).backup" | sed -E "s/\s+/_/g")

for d in $DIRS; do
	ALL_FILES="$(find $d -mindepth 1 -maxdepth 1)"
	for f in $ALL_FILES; do

		ROOT=$(echo "$f" | sed -E "s/([^\/]*)\/(.*)/\2/g")

		if [ -e "$HOME/$ROOT" ]; then
			# Backup
			mkdir -p "$BACKUP_LOC"
			mv -v "$HOME/$ROOT" "$BACKUP_LOC"
			echo "Moved $HOME/$ROOT to $BACKUP_LOC/$ROOT"
		fi
	done
done

echo "$FULL_COMMAND"
eval "$FULL_COMMAND"
