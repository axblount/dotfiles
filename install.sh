#!/bin/bash
set -e
# Install symlinks to your dotfiles.
# This script assumes that your dotfiles directory
# is ~/dotfiles.
#
# Any additional arguments are passed to stow.
# Stow will be verbose by default.
#
# Some useful examples:
#   ./install.sh        # Install/stow dotfiles
#   ./install.sh -n -v  # Do a dry run.
#   ./install.sh -R     # Re-stow dotfiles after
#                       # making changes
#   ./install.sh -D     # Uninstall dotfiles

# This needs to be fun from your dotfiles directory.
cd ~/dotfiles

# Make sure XDG config directories exist
mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}
mkdir -p ${XDG_DATA_HOME:-$HOME/.local/share}
mkdir -p ${XDG_CACHE_HOME:-$HOME/.cache}

# get a list of all subdirectories of ~/dotfiles
all_packages=$(\ls --color=never -1d */)

# Stow packages from each subdirectory of ~/dotfiles
stow -v $@ $all_packages

# If you have fonts in your dotfiles (and it's not
# a dry run) rebuild the font cache.
if [ -d "fonts/" ]; then
    case "$@" in
        *-n*) echo 'fc-cache -f -v ~/.fonts' ;;
        *) fc-cache -f -v ~/.fonts ;;
    esac
fi
