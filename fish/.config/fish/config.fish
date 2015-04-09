# no greeting
set fish_greeting

set -gx PATH $PATH $HOME/bin
set -gx EDITOR vim
set -gx PAGER less

# Enables 256 colors in vim
if set -q TMUX
    set -gx TERM screen-256color
else
    set -gx TERM xterm-256color
end

alias ls 'ls -bkF --color=auto'
alias tree 'tree -F --dirsfirst'
alias rm 'rm -iv'
alias cp 'cp -iv'
alias mv 'mv -iv'
alias grep 'grep --color=auto'
alias fgrep 'grep -F'
alias egrep 'grep -E'

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch (set_color yellow)
set __fish_git_prompt_color_upstream_ahead (set_color green)
set __fish_git_prompt_color_upstream_behind (set_color red)

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'

