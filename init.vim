" Vim et Neovim : aucun téléchargement ni plugin obligatoire.
set nocompatible
syntax enable
filetype plugin indent on
set number relativenumber
set autoindent
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set hidden
set incsearch hlsearch ignorecase smartcase
set mouse=a
set encoding=utf-8
set laststatus=2
set updatetime=300
set timeoutlen=500
set list
set listchars=tab:»·,trail:·,extends:>,precedes:<
set noerrorbells
if has('termguicolors')
  set termguicolors
endif
if has('clipboard')
  set clipboard=unnamedplus
endif
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
" updatetime ne sauvegarde pas le fichier : :write reste explicite.
