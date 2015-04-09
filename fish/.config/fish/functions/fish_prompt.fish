function fish_prompt
    # save the status from the last command
    # otherwise it gets clobbered while building
    # the prompt
    set -l saved_status $status
    set -l top ┌
    set -l bot └
    set -l line ─

    # first line
    echo -n $top
    set_color brown
    echo -n (hostname)
    set_color green
    echo -n (whoami)
    set_color purple
    echo (short_pwd)

    # second line
    set_color normal
    echo -n $bot

#    if [ -d '.git' ]
#        set -l branch (fishgit branch)
#        echo -n "$line("
#        if [ $branch = 'master' ]
#            set_color -o red
#        else
#            set_color -o yellow
#        end
#        echo -n $branch
#        set_color normal
#        echo -n ")$line"
#
#       if fishgit dirty
#            echo -n "["
#            set_color blue
#            echo -n "+"
#            set_color normal
#            echo -n "]$line"
#        end
#    end

#    printf '%s' (__fish_git_prompt)
#    set_color normal

    echo -sn (status_smiley $saved_status) ' '
end

