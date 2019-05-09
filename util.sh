#!/bin/sh
set -e

print_help() {
    echo "\
available commands:
    fonts
    install
    xdg
    help"
}

if [ $# -eq 0 ]; then
    cmd=help
else
    cmd=$1
    shift
fi

case "$cmd" in
    fonts)
        echo 'rebuliding the font cache from ~/.fonts ...'
        case "$@" in
            *-n*) echo 'fc-cache -f -v ~/.fonts' ;;
            *) fc-cache -f -v ~/.fonts ;;
        esac
        ;;
    install)
        echo 'installing all packages...'
        all_packages=$(\ls --color=never -1d */ | \sed '/^[@_]/d')
        stow $@ $all_packages
        ;;
    xdg)
        echo 'ensuring xdg directories exist...'
        mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}
        mkdir -p ${XDG_DATA_HOME:-$HOME/.local/share}
        mkdir -p ${XDG_CACHE_HOME:-$HOME/.cache}
        ;;
    help)
        print_help
        ;;
    *)
        echo 'Unknown command:' $cmd
        print_help
        ;;
esac
