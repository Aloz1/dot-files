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

"""" vim-plug Stuff """"
call plug#begin('~/.local/share/nvim/plugged')

" To update vim-plug itself, you need to use PlugUpgrade

Plug 'ayu-theme/ayu-vim'
Plug 'hashivim/vim-vagrant'
Plug 'dag/vim-fish'
Plug 'lervag/vimtex'
Plug 'aklt/plantuml-syntax'
Plug 'neovimhaskell/haskell-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'udalov/kotlin-vim'
Plug 'perost/modelica-vim'

call plug#end()

"""" General options """"

" Spell checking language
set spelllang=en_au

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
    autocmd BufRead,BufNewFile *.mo set filetype=modelica
    autocmd BufRead,BufNewFile *.tpl set filetype=susan
    autocmd FileType markdown,tex,text setl linebreak breakindent
    autocmd FileType 64tass,asm setl noet sw=8 ts=8
    autocmd FileType python setl et sw=4 ts=4
    autocmd FileType ruby setl et sw=2 ts=2
    autocmd FileType vhdl setl et sw=4 ts=4
    autocmd FileType yaml setl et sw=2 ts=2
augroup END

let tass64_w65c02=1

"""" Terminal colour theme """"
set termguicolors       " Enables 'true colour' support.
let ayucolor="dark"   " One of 'light', 'mirage' or 'dark'
colorscheme ayu

"""" Key mappings """"
noremap <Up> <C-Y>
noremap <Down> <C-E>
map  <C-K> :pyf /usr/share/clang/clang-format.py<cr>
imap <C-K> <c-o>:pyf /usr/share/clang/clang-format.py<cr>
