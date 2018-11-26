#!/bin/bash
#
# Stuff for interactive shells

# if the shell isn't interactive, get out of here.
[[ "$-" != *i* ]] && return

# enable bash completion if it is available
[ -f /etc/bash_completion ] && source /etc/bash_completion

set -o vi
set -o noclobber

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

shopt -s extglob
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

smiley() {
    if [ $? = 0 ]; then
        echo -en "$1:)"
    else
        echo -en "$2:("
    fi
}

source ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWCOLORHINTS=1

# tput with escaped output for non-printing characters
tpute() {
    echo "\[$(tput $@)\]"
}

set_prompt() {
    # clear color and style
    local C=$(tpute sgr0)
    # make bold
    local B=$(tpute bold)

    # foreground codes
    # high intensity!!!
    local RED=$(tpute setaf 9)
    local GREEN=$(tpute setaf 10)
    local BLUE=$(tpute setaf 12)
    local PURPLE=$(tpute setaf 124)
    local CYAN=$(tpute setaf 14)

    PS1="$B$RED\$$BLUE\u$C$GREEN at $B\h$C$PURPLE in $B\w$C\$(__git_ps1 ' (%s)')"
    PS1="$PS1\n$C\$(smiley $GREEN $RED)$C "
    PS2=" $CYAN>$C "
}

set_prompt
unset -f set_prompt
unset -f tpute
