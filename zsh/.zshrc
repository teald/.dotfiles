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
export PATH="$PATH:/home/teal/.local/bin"
