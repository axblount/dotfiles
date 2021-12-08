# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

# enable bash completion if it is available
[ -f /etc/bash_completion ] && source /etc/bash_completion

set -o vi
set -o noclobber

# some more ls aliases
alias ls='ls -bkF --color=auto'
alias tree='tree -F --dirsfirst -I .git'
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'
alias grep='grep --color=auto'
alias :q='exit'

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
        source venv/bin/activate
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

function __pre_ps1() {
    echo -en "\[\e[01;34m\]"'\u@\h:\w'"\[\e[0m\]"
}

function __post_ps1() {
    if [ $1 = 0 ]; then
        echo -en "\[\e[01;32m\]"
    else
        echo -en "\[\e[01;31m\]"
    fi
    echo -en $([ -n "${VIRTUAL_ENV}" ] && echo venv)'\$'"\[\e[0m\]"
}

function __set_prompt() {
    local last=$?
    __git_ps1 "$(__pre_ps1)" " $(__post_ps1 $last) "
}

PROMPT_COMMAND=__set_prompt
