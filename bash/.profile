# ~/.profile: executed by the command interpreter for login shells.

export PATH="$HOME/.local/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export EDITOR=vim
export VISUAL=vim
export PAGER=less

export PATH="$HOME/.rakudobrew/bin:$PATH"
rakudobrew() {
    local command
    command="$1"
    if [ "$#" -gt 0 ]; then
        shift
    fi
    case "$command" in
        shell) eval "`rakudobrew "sh" "$@"`";;
        *) command rakudobrew "$command" "$@";;
    esac
}
