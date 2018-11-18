" Vi compatibility
set nocompatible

" Fix backspace behavior
set backspace=indent,eol,start

set nomodeline
set autoread
set clipboard=unnamedplus
set splitright

" Encoding
set encoding=utf-8

" Numbering
set number
set relativenumber
set ruler
set noshowmode

" Detect running OS
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" Set makeprg
if g:os == "Linux"
    set makeprg=make\ -f\ ~/.vim/Makefile
endif

" Call pathogen if there's no native package manager
if !has('packages')
    execute pathogen#infect('pack/plugins/start/{}', 'pack/themes/opt/{}')
endif

" Airline settings
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#vimtex#enabled = 1
let g:airline#extensions#vimtex#left = "{"
let g:airline#extensions#vimtex#right = "}"
let g:airline#extensions#vimtex#compiled = "c₁"
let g:airline#extensions#vimtex#continuous = "c"
let g:airline#extensions#vimtex#viewer = "v"

" Vimtex settings
let g:vimtex_enabled = 1

" Temporary files
set noswapfile
set undofile
set undodir=~/.vim/undo

" External configuration
set exrc
set secure

" Indentation settings
set cindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Syntax highlight
filetype plugin indent on
syntax enable
set background=light
colorscheme solarized

" Enable spell check for Markdown
au BufRead *.md setlocal spell

" Runner
function! Run()
    if !empty(glob("~/.vim/Makefile"))
        !cp ~/.vim/io.inc "%:p:h"
        make! "%:r"
        !rm io.inc
        !./%<
    elseif expand("%:e")=="cpp" || expand("%:e")=="cxx"
        !g++ -std=c++11 -I. -Wall -Wextra % -o %< && ./%<
    elseif expand("%:e")=="c"
        !gcc -std=c99 -Wall -Wformat-security -Winit-self -Wno-pointer-sign -Wignored-qualifiers -Wfloat-equal -Wnested-externs -Wmissing-field-initializers -Wmissing-parameter-type -Wold-style-definition -Wold-style-declaration -Wstrict-prototypes -Wtype-limits -Wswitch-default -lm -O2 % -o ./%< && ./%<
    elseif expand("%:e")=="asm"
        !~/.vim/build_asm.sh % && ./%<
    elseif expand("%:e")=="hs"
        !ghc % && ./%<
    endif
endfunction

" Key mappings
map <F4> gg=G
map <F5> :call Run()<CR>

" For binary files
augroup Binary
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost * if &bin | %!xxd
    au BufReadPost * set ft=xxd | endif
    au BufWritePre * if &bin | %!xxd -r
    au BufWritePre * endif
    au BufWritePost * if &bin | %!xxd
    au BufWritePost * set nomod | endif
augroup END

" Disable YCM questions
let g:ycm_confirm_extra_conf = 0

" Set folding method
set foldmethod=syntax
