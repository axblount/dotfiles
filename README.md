Dotfiles
========

This repository contains all my important dotfiles.
I manage it with GNU Stow, as outlined by [xero][1].

## Install
```sh
$ cd
$ git clone https://github.com/axblount/dotfiles
$ cd dotfiles
$ ./install.sh
```

`install.sh` runs stow against all repositories in the folder.
Any arguments passed to the script are given to stow.

### Examples
#### Perform a dry run, showing what links will be created:
```sh
./install.sh -n -v
```

#### Uninstall all repositories:
```sh
./install.sh -D
```

[1]: https://github.com/xero/dotfiles
