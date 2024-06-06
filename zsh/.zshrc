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

if [ -e /home/teal/.nix-profile/etc/profile.d/nix.sh ]; then . /home/teal/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Created by `pipx` on 2024-06-05 15:09:48
export PATH="$PATH:$HOME/.local/bin"

DEFAULT_NIX_DEV_SHELL_PATH="$HOME/.dotfiles/nix/dev_env.nix"
NIX_DEV_PATH="${NIX_DEV_PATH}:-${DEFAULT_NIX_DEV_SHELL_PATH}"

# Enter nix development shell, if nix is available.
if [ command -v nix-shell ]; then
  nix-shell $NIX_DEV_PATH 
fi
