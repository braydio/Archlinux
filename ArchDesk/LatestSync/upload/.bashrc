# ~/.bashrc
# Exit if not running interactively
[[ $- != *i* ]] && return

# Environment Variables
export TERM=xterm-256color
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export EDITOR=nvim

# Changed below when bash wasnt working, now idk which to use
# export PATH="$PATH:/usr/local/bin"
# export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export FZF_DEFAULT_OPTS="--color=fg:#ebdbb2,bg:#282828,hl:#458588" # Colors for FZF
# export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
PATH=usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin::/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
# Add pyenv to PATH
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"

# Aliases from .bash_aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# SSH Persistence (Auth) - check if running
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)"
fi

# Bash Completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash # Fuzzy finder Bash completion

bind 'TAB:menu-complete'               # Tab cycling
bind '"\e[Z": menu-complete-backward'  # Shift tab back-cycling
bind '"\e[B": history-search-forward'  # History aware completion
bind '"\e[A": history-search-backward' # History aware backwards
bind "set colored-stats on"

## Functions
cdr() {
  clear && cd "$1" && ls -a --color=auto
}

cds() {
  cd "$1" && ls -a --color=auto
}

cdc() {
  cd "$HOME/$1" && ls -a --color=auto
} # Because fuck a tilde (is that a tilde? Is that even how you spell it?)

# Git Aliases

# Def Prompt
PS1='\[\e[0;32m\][\u@\h \W]\$ \[\e[m\]'

# Only load Liquid Prompt in interactive shells, not from a script or from scp
# [[ $- = *i* ]] && source ~/liquidprompt/liquidprompt
