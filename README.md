Dotfiles
========

This repository contains all my important dotfiles.
I manage it with [GNU Stow][2], as outlined by [xero][1] and [Kraymer][3].


Install
-------

1. Obtain a copy of [GNU Stow][2].
    ```sh
    sudo emerge app-admin/stow
    ```
2. Set `$XDG_CONFIG_HOME`, `$XDG_DATA_HOME`, and `$XDG_CACHE_HOME`. I use:
    ```sh
    XDG_CONFIG_HOME=$HOME/.config
    XDG_DATA_HOME=$HOME/.local/share
    XDG_CACHE_HOME=$HOME/.cache
    ```
3. Clone and stow.
    ```sh
    cd ~
    git clone https://github.com/axblount/dotfiles
    cd dotfiles
    stow */
    ```
4. Install fonts.
    ```sh
    fc-cache -f -v $XDG_DATA_HOME/fonts
    ```
    NOTE: This is obsolete on most systems since I switched to
    [medialibs/fontconfig][4] on Gentoo. I no longer embed font files
    in this repo.


Notes & Reminders
-----------------

To list all the dotfiles use `tree -a -I .git`.


### Stow

All the non-repo directories are listed in `.stow-local-ignore`. This should
allow you to use `stow */` to install all the packages. Installing individually
is still a better idea.

Use `stow -n <package>/` to do a dry run.


### Git

Private config goes in `~/.gitconfig.private` which is explicitly NOT included
in this repository.


[1]: https://github.com/xero/dotfiles
[2]: https://www.gnu.org/software/stow/
[3]: https;//github.com/Kraymer/F-dotfiles
[4]: https://wiki.gentoo.org/wiki/Fontconfig
