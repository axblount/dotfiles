#!/bin/sh
# ~/.profile: executed by the command interpreter for login shells.

export PATH="$HOME/bin:$PATH"

# Check for interactive shell
case $- in
    *i*) ;;
    *) return ;;
esac

export EDITOR=vim
export VISUAL=vim
export PAGER=less

if [ -n "$BASH" -a -z "$POSIXLY_CORRECT" ];
then
    . "$HOME/.bashrc"
fi
