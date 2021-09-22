set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set scrolloff=999

" ---- Minimal configuration:
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set wrap!

set number relativenumber
set wildmode=longest,list   " get bash-like tab completions
set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard+=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download
" language package)
" " set noswapfile            " disable creating swap file
" " set backupdir=~/.cache/vim " Directory to store backup files.")

" keymaps
" let g:ctrlp_working_path_mode = 0
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_clear_cache_on_exit = 0
endif
" let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|__pycache__'
noremap <m-o> :CtrlPCurWD<CR>
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
      \ 'AcceptSelection("t")': ['<cr>'],
      \ }
noremap ss :Obsession<CR>
noremap <m-,> :tabmove -1<CR>
noremap <m-.> :tabmove +1<CR>
noremap <m-j>  :tabnext<CR>
noremap <m-k>  :tabprevious<CR>
noremap <m-n>  :tabclose<CR>
map <esc> :noh<CR>
noremap <m-r> <c-o>
noremap <m-t> :call CocAction('jumpDefinition', 'tabe')<CR>
noremap <m-f> :call CocAction('jumpDefinition')<CR>
noremap <m-u> :call CocAction('jumpReferences')<CR>

xnoremap <m-s> y<Esc>:CocSearch <C-R>"

call plug#begin()
Plug 'raimondi/delimitmate'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'peitalin/vim-jsx-typescript'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


let g:tokyonight_style = "night"
colorscheme tokyonight

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

