#!/bin/sh

if [ "$PWD" != "$HOME/dotfiles" ]; then
    echo [ERROR] "run this from ~/dotfiles"
    exit 1
fi

stow -v $@ $(\ls -1d */ | cut -d'/' -f1)
