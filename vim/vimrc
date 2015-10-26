" Vundle requirements
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" https://github.com/tpope/vim-fugitive
Plugin 'tpope/vim-fugitive'

" https://github.com/altercation/vim-colors-solarized.git
Plugin 'altercation/vim-colors-solarized'

" vim-markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" vim-splunk
Plugin 'yorokobi/vim-splunk'
Plugin 'PProvost/vim-ps1'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set modeline

if has('gui_running')
    set background=light
else
    set background=dark
endif

set hlsearch
set autoindent

" size of a hard tabstop
set tabstop=4

" size of an "indent"
set shiftwidth=4

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=4

" make "tab" insert indents instead of tabs at the beginning of a line
set smarttab

" always uses spaces instead of tab characters
set expandtab

syntax on

let g:vim_markdown_folding_disabled=1
let g:ps1_nofold_blocks=1
