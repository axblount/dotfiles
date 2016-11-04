Dotfiles
========

This repository contains all my important dotfiles.
I manage it with [GNU Stow][2], as outlined by [xero][1].

Install
-------

```sh
$ sudo apt-get install stow # obviously this will change based on distro
$ cd
$ git clone --recursive https://github.com/axblount/dotfiles
$ cd dotfiles
$ ./install.sh
```

`install.sh` runs stow against all repositories in the folder.
Any arguments passed to the script are given to stow. The recursive
clone is necessary because I use git submodules as part of my vim setup.

If manage `~/.fonts` as part of your dotfiles, `install.sh` will also
rebuild the font cache.

### Examples
#### Perform a dry run, showing what links will be created:
```sh
cd ~/dotfiles
./install.sh -n -v
```

#### Uninstall all repositories:
```sh
cd ~/dotfiles
./install.sh -D
```

[1]: https://github.com/xero/dotfiles
[2]: https://www.gnu.org/software/stow/
