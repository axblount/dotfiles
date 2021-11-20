Dotfiles
========

This repository contains all my important dotfiles.
I manage it with [GNU Stow][2], as outlined by [xero][1] and [Kraymer][3].

To view a listing of the dotfiles use `tree -a -I .git`.

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

[1]: https://github.com/xero/dotfiles
[2]: https://www.gnu.org/software/stow/
[3]: https;//github.com/Kraymer/F-dotfiles
