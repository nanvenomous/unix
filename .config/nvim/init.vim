set scrolloff=999
set ignorecase              " case insensitive 

" ---- possible speed increases
syntax on                   " syntax highlighting
set synmaxcol=200
set foldmethod=manual
set noshowmatch
set regexpengine=1

" ---- Minimal configuration:
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set wrap!

set number relativenumber

set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set lazyredraw

set clipboard+=unnamedplus   " using system clipboard

if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_clear_cache_on_exit = 0
endif

noremap <silent>go :CtrlPCurWD<CR>
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
      \ 'AcceptSelection("t")': ['<cr>'],
      \ }
noremap <silent>gj :+10<CR>
noremap <silent>gk :-10<CR>
noremap <silent>gb <c-o>
noremap ss :Obsession<CR>
noremap <m-,> :tabmove -1<CR>
noremap <m-.> :tabmove +1<CR>
noremap <m-j>  :tabnext<CR>
noremap <m-k>  :tabprevious<CR>
noremap <m-n>  :tabclose<CR>
map <esc> :noh<CR>

call plug#begin()
Plug 'raimondi/delimitmate'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
" Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
call plug#end()
" Plug 'Vimjas/vim-python-pep8-indent'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:tokyonight_style = "night"
colorscheme tokyonight

" ---- https://github.com/neovim/nvim-lspconfig

lua << EOF
require'lspconfig'.gopls.setup{}
require'lspconfig'.tsserver.setup{}
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
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
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
  require('lspconfig')['gopls'].setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
EOF

