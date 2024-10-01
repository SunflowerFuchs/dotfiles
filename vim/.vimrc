" Vim Settings
set backupcopy=yes
set nocompatible
set number relativenumber
set tabstop=4

" Convenient command to see the difference between the current buffer and the
" " file it was loaded from, thus the changes you made.
command! Diff vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis

" Plugin Settings
let NERDTreeShowHidden=1

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Plugin configuration
if ! empty(globpath(&rtp, 'autoload/plug.vim'))
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
call plug#end()
endif
