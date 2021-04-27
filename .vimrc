set number relativenumber
set ignorecase

set background=dark

set mouse=a
set shell=/usr/bin/bash

" adding appropriate comment syntax
autocmd FileType python setlocal commentstring=#%s
autocmd FileType xonsh setlocal commentstring=#%s

" ---- Minimal configuration:
set shiftwidth=3  " Set number of spaces per auto indentation
set tabstop=3     " Number of spaces that a <Tab> in the file counts for
set autoindent
set smartindent   " Do smart autoindenting when starting a new line

" makes the local clipboard the global clipboard"
if has('macunix')
	set clipboard=unnamed
else
	set clipboard=unnamedplus
endif
syntax on

" saves clipboard when exiting vim (has xsel as dependency)
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" font size
set guifont=Monospace:h20

" Vim Plug installs
call plug#begin()

	Plug 'raimondi/delimitmate'
	Plug 'kien/ctrlp.vim'
	Plug 'tpope/vim-surround'
	Plug 'ervandew/supertab'
	Plug 'linkinpark342/xonsh-vim'
	Plug 'tpope/vim-commentary'
	Plug 'Vimjas/vim-python-pep8-indent'
	Plug 'drewtempelmeyer/palenight.vim'
	Plug 'fatih/vim-go'

call plug#end()
