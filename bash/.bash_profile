source ~/.profile
[[ $- == *i* ]] && source ~/.bashrc

# if this is being run from tty1, we are logging in.
# also, make sure this is a system with sway!
if [ -n "$(type -P sway)" ] && [ "$(tty)" = "/dev/tty1" ]; then
    # setup sway
    export MOZ_ENABLE_WAYLAND=1
    export MOZ_WEBRENDER=1
    export XDG_SESSION_TYPE=wayland
    export XDG_CURRENT_DESKTOP=sway
    dbus-run-session sway
fi
