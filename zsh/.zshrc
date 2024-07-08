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

# Locales
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

# WRT using dotfiles, this will be updated when micromamba is installed.
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/nix/store/bfd6gwj5klgdfbkjw3qavfrwk7y9aiyb-micromamba-1.5.8/bin/micromamba';
export MAMBA_ROOT_PREFIX='bash';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# Alias for micromamba
alias mamba="micromamba"

# Prompt engineering.
# Git info (prints above the standard prompt for compactness).
source ~/git_prompt.sh
GIT_PS1_SHOWDIRTYSTATE="true"
NEWLINE='
'  # This is kinda funny, when you think about it.
TIME='%F{gray}%D{%H:%M:%S}%f'
DATE='%F{yellow}%D{%b %d, %Y}%f'

# TODO: Genuinely cursed formatting here.
NEWLINE=$'\n'
PS1_ABOVE="$DATE @ $TIME$NEWLINE"
PS1_BELOW='%F{green}%n%f@%F{magenta}%m%f | %F{red}%c%f%F{blue}$(__git_ps1 " (%s)")%f|\$ '

setopt PROMPT_SUBST ; PS1=$PS1_ABOVE$PS1_BELOW
#export PROMPT=$PROMPT"%F{green}%n%f|%F{blue}%D{%I:%M:%S}%f|%F{magenta}%d%f $ "
