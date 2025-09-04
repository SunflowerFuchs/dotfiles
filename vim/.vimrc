" Vim Settings
set backupcopy=yes
set nocompatible
set number relativenumber
set tabstop=4
set shiftwidth=4

" Convenient command to see the difference between the current buffer and the
" " file it was loaded from, thus the changes you made.
command! Diff vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis

" Alias for NerdTree
command Dir NERDTree

" Plugin Settings
let NERDTreeShowHidden=1
let g:csv_highlight_column = 'y'
let g:polyglot_disabled = ['csv']
let g:airline_powerline_fonts = 1

" Start NERDTree when Vim is started without file arguments.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
"     \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Plugin configuration
if ! empty(globpath(&rtp, 'autoload/plug.vim'))
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'mechatroner/rainbow_csv'
call plug#end()
endif

nnoremap <expr> <C-Left> get(b:, 'rbcsv', 0) == 1 ? ':RainbowCellGoLeft<CR>' : '<C-Left>'
nnoremap <expr> <C-Right> get(b:, 'rbcsv', 0) == 1 ? ':RainbowCellGoRight<CR>' : '<C-Right>'
nnoremap <expr> <C-Up> get(b:, 'rbcsv', 0) == 1 ? ':RainbowCellGoUp<CR>' : '<C-Up>'
nnoremap <expr> <C-Down> get(b:, 'rbcsv', 0) == 1 ? ':RainbowCellGoDown<CR>' : '<C-Down>'
