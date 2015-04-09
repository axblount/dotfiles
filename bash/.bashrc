#!/bin/bash

# do nothing in non interactive sessions
[ -z "$PS1" ] && return

# enable bash completion if it is available
[ -f /etc/bash_completion ] && source /etc/bash_completion

# Set the TERM so that tmux uses 256 colors
if [ -n "$TMUX" ]; then
    export TERM=screen-265color
else
    export TERM=xterm-256color
fi

# some more ls aliases
alias ls='ls -bkF --color=auto'
alias tree='tree -F --dirsfirst'
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'
alias grep='grep --color=auto'
alias fgrep='grep -F'
alias egrep='grep -E'

shopt -s checkwinsize
shopt -s histappend
shopt -s nocaseglob

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=

# everything else is prompt...

smiley() {
    if [ $? = 0 ]; then
        echo -en "$1:)"
    else
        echo -en "$2:("
    fi
}

set_prompt() {
    # clear color and style
    local C="\[\e[0m\]"
    # make bold
    local B="\[\e[1m\]"

    # these probably arent a good idea
    local UNDER="\[\e[4m\]"
    local BLINK="\[\e[5m\]"
    local INVERSE="\[\e[7m\]"

    # foreground codes
    local BLACK="\[\e[30m\]"
    local RED="\[\e[31m\]"
    local GREEN="\[\e[32m\]"
    local BROWN="\[\e[33m\]"
    local BLUE="\[\e[34m\]"
    local PURPLE="\[\e[35m\]"
    local CYAN="\[\e[36m\]"
    local LGRAY="\[\e[37m\]"

    # background codes
    local BLACK_BACK="\[\e[40m\]"
    local RED_BACK="\[\e[41m\]"
    local GREEN_BACK="\[\e[42m\]"
    local BROWN_BACK="\[\e[43m\]"
    local BLUE_BACK="\[\e[44m\]"
    local PURPLE_BACK="\[\e[45m\]"
    local CYAN_BACK="\[\e[46m\]"
    local LGRAY_BACK="\[\e[47m\]"

    PS1="$B$RED\$$BLUE\u$C$GREEN at $B\h$C$PURPLE in $B\w"
    PS1="$PS1\n$C\$(smiley $GREEN $RED) $C"

    PS2="$YELLOW>$C "
}

set_prompt
unset -f set_prompt