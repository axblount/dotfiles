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

# Stow packages from each subdirectory of ~/dotfiles
stow -v $@ $(\ls -1d */)

# If you have fonts in your dotfiles (and it's not
# a dry run) rebuild the font cache.
if [ -d "fonts/.fonts" ]; then
    case "$@" in
        *-n*) echo 'fc-cache -f -v ~/.fonts' ;;
        *) fc-cache -f -v ~/.fonts ;;
    esac
fi
