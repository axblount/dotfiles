" Tools to create and restore sessions
" Sessions must be created manually, but update automatically

function! MakeSession()
    let b:session_dir = $XDG_DATA_HOME . "/nvim/sessions" . getcwd()
    if (filewriteable(b:sessiondir) != 2)
        exe 'silent !mkdir -p' b:session_dir
        redraw!
    endif
    let b:filename = b:session_dir . '/session.vim'
    exe 'mksession!' b:filename
endfunction

" Update an already existing session
function! UpdateSession()
    let b:session_dir = $XDG_DATA_HOME . "/nvim/sessions" . getcwd()
    let b:session_file = b:session_dir . "session.vim"
    if (filereadable(b:session_file))
        exe "mksession!" b:filename
    endif
endfunction

" Load an existing session
function! LoadSession()
    let b:session_dir = $XDG_DATA_HOME . "/nvim/sessions" . getcwd()
    let b:session_file = b:session_dir . "session.vim"
    if (filereadable(b:session_file))
        exe 'source' b:session_file
    else
        echo "No session loaded."
    endif
endfunction

augroup session_management
    au VimEnter * nested :call LoadSession()
    au VimLeave * :call UpdateSession()
augroup end
map <leader>m :call MakeSession()<CR>

