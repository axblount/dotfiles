#!/bin/bash
#
# Stuff for interactive shells

# enable bash completion if it is available
[ -f /etc/bash_completion ] && source /etc/bash_completion

set -o vi

# some more ls aliases
alias ls='ls -bkF --color=auto'
alias tree='tree -F --dirsfirst'
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'
alias grep='grep --color=auto'
alias :q='exit'
alias xcopy='xclip -selection clipboard -i'
alias xpaste='xclip -selection clipboard -o'

shopt -s checkwinsize
shopt -s histappend
shopt -s nocaseglob

HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=

nfs() {
    ssh ${1}_${2}@ssh.phx.nearlyfreespeech.net
}

serve() {
    port="${1:-8888}"
    if type -P python3; then
        python3 -m http.server $port
    else
        python2 -m SimpleHTTPServer $port
    fi
}

# activate the virtual environment
activate() {
    if [ -f .venv/bin/activate ]; then
        source .venv/bin/activate
        return 0
    elif [ -f venv/bin/activate ]; then
        source .venv/bin/activate
        return 0
    else
        echo "Couldn't find virtualenv."
        return 1
    fi
}

# everything else is prompt...

source ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWCOLORHINTS=1

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

    PS1="$B$RED\$$BLUE\u$C$GREEN at $B\h$C$PURPLE in $B\w$C\$(__git_ps1 ' (%s)')"
    PS1="$PS1\n$C\$(smiley $GREEN $RED) $C"
    PS2="   $CYAN>$C "
    PS3="     $BLUE>$C "
    PS4="       $PURPLE>$C "
}

set_prompt
unset -f set_prompt
