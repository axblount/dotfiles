#!/bin/sh

if [ "$PWD" != "$HOME/dotfiles" ]; then
    echo [ERROR] "run this from ~/dotfiles"
    exit 1
fi

# don't stow '.' or '.git'
for repo in $(find . -maxdepth 1 ! -path . ! -path '*.git' -type d); do
    stow $@ "$(basename "$repo")"
done
