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

# Locales
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

# WRT using dotfiles, this will be updated when micromamba is installed.

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
PS1_ABOVE="🌈 🗓️ $DATE 🕰️ $TIME$NEWLINE"
PS1_BELOW='%F{green}%n%f@%F{magenta}%m%f | %F{red}%c%f%F{blue}$(__git_ps1 " (%s)")%f|\$ '

setopt PROMPT_SUBST ; PS1=$PS1_ABOVE$PS1_BELOW
#export PROMPT=$PROMPT"%F{green}%n%f|%F{blue}%D{%I:%M:%S}%f|%F{magenta}%d%f $ "

alias local_venv='find . -maxdepth 1 -name "VENV*" -or -name ".venv" -and -type d | sed 1q | xargs -I {} source {}/bin/activate'

# Load pyenv automatically by appending
# the following to 
# ~/.zprofile (for login shells)
# and ~/.zshrc (for interactive shells) :

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Rust
. $HOME/.cargo/env

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/teald/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/teald/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/teald/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/teald/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/teald/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/teald/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<


# Created by `pipx` on 2024-08-30 01:50:43
export PATH="$PATH:/home/teald/.local/bin"

# Created by `pipx` on 2024-08-30 01:52:04
export PATH="$PATH:/usr/local/bin"
