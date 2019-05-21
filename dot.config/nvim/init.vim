" Fallback shell when fish is detected
let g:shell_cmd="/bin/sh"

" Function to make sure fish is used for :terminal
function! OpenTerm(arg)
    let &shell='/usr/bin/fish'
    execute "terminal " . a:arg
    let &shell=g:shell_cmd
endfunction

" Check to see if we're currently using fish
if &shell =~# 'fish$'
    let &shell=g:shell_cmd
    command! -nargs=? Terminal call OpenTerm(<q-args>)
endif

" Turn on relative numbering and syntax highlighting
set number relativenumber
syntax on

" Tab settings (maybe this should be different, depending on file type???)
set shiftwidth=4
set tabstop=4
set expandtab
set colorcolumn=100

" Disable python recommended style
let g:python_recommended_style=0

" Autocommands
augroup numbertoggle
    autocmd!
    autocmd! BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd! BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

augroup filetypesettings
    autocmd!
    autocmd BufReadPost * if match(expand('%:p'), '/srcpkgs/[^/]\+/template') != -1 | setl noet | endif
    autocmd FileType ruby setl et sw=2 ts=2
    autocmd FileType python setl noet sw=4 ts=4
augroup END

"""" Vundle Stuff """"
set nocompatible
filetype off

" Setup vundle
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

" Let vundle manage vundle
Plugin 'VundleVim/Vundle.vim'

" All other plugins
Plugin 'hashivim/vim-vagrant'
Plugin 'dag/vim-fish'
Plugin 'tmux-plugins/vim-tmux-focus-events'

call vundle#end()
filetype plugin indent on
