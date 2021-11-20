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
alias tree='tree -F --dirsfirst'
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

function smiley() {
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
function tpute() {
    echo -n "\[$(tput $@)\]"
}

function set_prompt() {
    local tri=""
    # clear style
    local c=$(tpute sgr0)
    # bold
    local b=$(tpute bold)

    # start first segment
    local s1="$(tpute setaf 0; tpute setab 21)"
    # transition from segment 1 to 2
    local s12="$(tpute setaf 21; tpute setab 45)$tri$(tpute setaf 0)"
    # transtion from segment 2 to default
    local s2c="$c$(tpute setaf 45)$tri$c"

    PS1="$s1 \u $s12 \w $s2c "
}
: <<COMMENT
function set_prompt() {
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
COMMENT

set_prompt
unset -f set_prompt
unset -f tpute
