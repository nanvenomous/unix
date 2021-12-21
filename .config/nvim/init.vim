set scrolloff=999
set ignorecase              " case insensitive 

" ---- possible speed increases
syntax on                   " syntax highlighting
" set synmaxcol=200
" set foldmethod=manual
" set noshowmatch
" syntax sync fromstart
" syntax sync minlines=10

" ---- Minimal configuration:
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set wrap!

set number relativenumber

set cursorline              " highlight current cursorline
" set ttyfast                 " Speed up scrolling in Vim
" set lazyredraw

set clipboard+=unnamedplus   " using system clipboard

if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_clear_cache_on_exit = 0
endif

noremap <silent>to :CtrlPCurWD<CR>
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
      \ 'AcceptSelection("t")': ['<cr>'],
      \ }
noremap <silent>gj :+10<CR>
noremap <silent>gk :-10<CR>
noremap <silent>gb <c-o>
noremap ss :Obsession<CR>
noremap <silent>tj  :tabnext<CR>
noremap <silent>tk  :tabprevious<CR>
noremap <silent>tn  :tabclose<CR>
noremap <silent>t, :tabmove -1<CR>
noremap <silent>t. :tabmove +1<CR>
noremap <leader>j :%!python -m json.tool<CR>
map <esc> :noh<CR>

call plug#begin()
Plug 'raimondi/delimitmate'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'mileszs/ack.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'Vimjas/vim-python-pep8-indent'
call plug#end()
"
"" ack.vim --- {{{

" Use ripgrep for searching ⚡️
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'

" Auto close the Quickfix list after pressing '<enter>' on a list item
" let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" Maps <leader>/ so we're ready to type the search keyword
nnoremap <silent>gs :Ack!<Space>
" }}}

" Navigate quickfix list with ease
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

let g:tokyonight_style = "night"
colorscheme tokyonight

" ---- https://github.com/neovim/nvim-lspconfig

lua << EOF
require'lspconfig'.gopls.setup{}
require'lspconfig'.pyright.setup{}
EOF

" ---- lsp
nnoremap <silent> gf <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gu <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>

" ---- tab completion
"  https://github.com/hrsh7th/nvim-cmp

set completeopt=menu,menuone,noselect

" S-Tab

lua <<EOF
-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
snippet = {
  expand = function(args)
  -- For `vsnip` user.
  vim.fn["vsnip#anonymous"](args.body)

  -- For `luasnip` user.
  -- require('luasnip').lsp_expand(args.body)

  -- For `ultisnips` user.
  -- vim.fn["UltiSnips#Anon"](args.body)
end,
},
    mapping = {
      ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
      }),
    },
  sources = {
    { name = 'nvim_lsp' },

    -- For vsnip user.
    { name = 'vsnip' },

    -- For luasnip user.
    -- { name = 'luasnip' },

    -- For ultisnips user.
    -- { name = 'ultisnips' },

    { name = 'buffer' },
    }
  })

-- Setup lspconfig.
  local servers = { 'gopls', 'pyright' }
  local nvim_lsp = require('lspconfig')
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end
EOF

