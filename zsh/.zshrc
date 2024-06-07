# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000

bindkey -v

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/teal/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

if [ -e $HOME.nix-profile/etc/profile.d/nix.sh ]; then
	. $HOME/.nix-profile/etc/profile.d/nix.sh;
fi # added by Nix installer

# Created by `pipx` on 2024-06-05 15:09:48
export PATH="$PATH:$HOME/.local/bin"

DEFAULT_NIX_DEV_SHELL_PATH="$HOME/.dotfiles/nix/dev_env.nix"

if [ ! $NIX_DEV_SHELL ]; then
	NIX_DEV_SHELL="$DEFAULT_NIX_DEV_SHELL_PATH"
fi

# Enter nix development shell, if nix is available.
if ! command -v nix-shell >/dev/null  -a [ NIX_LOAD != "no" ]; then
  nix-shell $NIX_DEV_SHELL
fi
