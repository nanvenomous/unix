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
set cursorline

set mouse=a

set number relativenumber

set cursorline              " highlight current cursorline
" set ttyfast                 " Speed up scrolling in Vim
" set lazyredraw

set clipboard=unnamedplus   " using system clipboard

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
noremap sf :w<CR>
noremap se :wqa<CR>
noremap sq :qa!<CR>
noremap sn :q!<CR>
noremap sj :wincmd j<CR>
noremap sk :wincmd k<CR>
noremap sl :wincmd l<CR>
noremap sh :wincmd h<CR>

nnoremap yp :let @+ = expand("%")<CR>
nnoremap yn :let @+ = expand("%:t")<CR>
nnoremap cj :GitGutterNextHunk<CR>
nnoremap ck :GitGutterPrevHunk<CR>
nnoremap ch :GitGutterPreviewHunk<CR>
nnoremap db :let g:gitgutter_diff_base = 'mainline'<CR>
nnoremap di :let g:gitgutter_diff_base = 'head'<CR>
noremap <silent>tj  :tabnext<CR>
noremap <silent>tk  :tabprevious<CR>
noremap <silent>tn  :tabclose<CR>
noremap <silent>th :tabmove -1<CR>
noremap <silent>tl :tabmove +1<CR>
noremap <leader>j :%!python -m json.tool<CR>
noremap <leader>f :set foldmethod=syntax<CR>
map <esc> :noh<CR>
nnoremap * :keepjumps normal! mi*`i<CR>

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
Plug 'airblade/vim-gitgutter'
Plug 'tveskag/nvim-blame-line'
Plug 'Konfekt/FastFold'
Plug 'sbdchd/neoformat'
Plug 'seblj/nvim-echo-diagnostics'
Plug 'jamestthompson3/sort-import.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

nnoremap <silent>ge <cmd>lua require("echo-diagnostics").echo_entire_diagnostic()<CR>
autocmd BufEnter * EnableBlameLine

" prettier
" let g:prettier#autoformat = 1
let g:neoformat_try_node_exe = 1
let g:neoformat_enabled_javascript = ['prettier', 'eslint']
let g:neoformat_enabled_typescript = ['prettier', 'eslint']
let g:neoformat_run_all_formatters = 1
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html Neoformat

nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

let g:gitgutter_diff_base = 'mainline'
let g:gitgutter_grep = 'rg'
autocmd BufWritePost * GitGutter

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
require'lspconfig'.tsserver.setup{}
EOF

" ---- lsp
nnoremap <silent> gf <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gu <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gl <cmd>lua vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})<CR>

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
  local servers = { 'gopls', 'pyright', 'tsserver' }
  local nvim_lsp = require('lspconfig')
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end

-- Setup nvim-treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "go", "typescript" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true
  },
}
EOF

