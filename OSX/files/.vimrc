" Basic .vimrc

" Enable line numbering
set number

" Enable syntax highlighting
syntax on

" Automatically detect file type
filetype on
filetype plugin on
filetype indent on

" Enable automatic indentations
set autoindent
set smartindent
set tabstop=4       " Display tabs as 4 spaces
set shiftwidth=4    " Use 4 spaces for each indentation level
set expandtab       " Convert tabs to spaces

" Enable incremental search
set incsearch
set hlsearch        " Highlight search results

" Enable visual mode for selecting blocks of text
set mouse=a         " Enable mouse in all modes

" Enable buffer file management
set hidden          " Allow switching buffers without saving

" Enable the status line
set laststatus=2

" Improve performance for large files
set lazyredraw      " Don't redraw while running macros
set ttyfast         " Faster output for fast terminals

" Enable system clipboard integration for copy-paste
set clipboard=unnamedplus

" Show indentation with visible characters
set list
set listchars=tab:»·,trail:·,extends:>,precedes:<

" Disable alert sounds
set noerrorbells
set visualbell
set t_vb=

" Auto-save changes every 100 keystrokes
set updatetime=100

" Update the screen after 300ms of inactivity
set timeoutlen=300

" fzf integration
set rtp+=/opt/homebrew/opt/fzf