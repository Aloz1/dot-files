" Config file for CoC

set updatetime=300 " 300 ms

" Aways show signcolumn
set signcolumn=yes

" Use <TAB> to trigger completion
" Note: A default is usually selected. To disable an initial selction, set
" `"suggest.noselect" to true.
" Note: Use command ':verbose imap <tab>' to make sure tab is not mapped
" by other plugins
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()

inoremap <expr><S-TAB> 
    \ coc#pum#visible() ? coc#pum#prev(1) :
    \ "\<C-h>"

" Remap <CR> to accept current completion selection
inoremap <silent><expr> <CR> 
    \ coc#pum#visible() ? coc#pum#confirm() : 
    \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <c-space to trigger completion
if has('nvim')
    inoremap <slient><expr> <c-space> coc#refresh()
else
    inoremap <slient><expr> <c-@> coc#refresh()
endif

" Use '[g' and ']g' to navigate diagnostics
" use ':CocDiagnostics' to get all diagnostics of current buffer
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Go to code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

" Highlight symbol and its references when cursor is on it
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Format selected code
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Apply code actions to selected code block
" Example: '<leader>aap' for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Rempat keys for applying code actions at cursor position
nmap <leader>ac <Plug>(coc-codeaction-cursor)
" Rempat keys for applying code actions throughout buffer
nmap <leader>as <Plug>(coc-codeaction-source)
" Apply preferred quickfixx action for current lines diagnostic
nmap <leader>qf <Plug>(coc-fix-current)

" Remap keys for refactoring code
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Map function and class text objects
" Note: Requires 'textDocument.documentSymbol' support from lsp
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows / popups
if has('nvim-0.4.0') || has('patch-8.2.075')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections range
" Requires 'textDocument/selectionRange' support of language
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add ':Format' command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add ':Fold' command to fold current buffer
command! -nargs=? Fold   :call CocActionAsync('fold', <f-args>)

" Add ':OR' command to organize/sort imports of current buffer
command! -nargs=0 OR     :call CocActionAsync('runCommand', 'editor.action.organizeImports')

" Add statusline support
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
