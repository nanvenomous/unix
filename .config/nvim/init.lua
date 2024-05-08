require('plugins')
require('lsp')

vim.o.scrolloff = 999

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = false

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
-- vim.bo.softtabstop = 2

vim.opt.clipboard = 'unnamedplus'
vim.opt.cursorline = true

vim.opt.termguicolors = true
vim.cmd [[ colorscheme spaceduck ]]

local keymap = vim.api.nvim_set_keymap
local nOpts = { noremap = true }
local nsOpts = { noremap = true, silent = true }

keymap('n', 'cj', ':GitGutterNextHunk<CR>', nOpts)
keymap('n', 'ck', ':GitGutterPrevHunk<CR>', nOpts)
keymap('n', 'ch', ':GitGutterPreviewHunk<CR>', nOpts)
-- nnoremap db :let g:gitgutter_diff_base = 'mainline'<CR>
-- nnoremap di :let g:gitgutter_diff_base = 'head'<CR>

keymap('n', 'gj', ':+10<CR>', nsOpts)
keymap('n', 'gk', ':-10<CR>', nsOpts)
keymap('n', 'gb', '<c-o>', nOpts)
keymap('n', 'gs', ':Ack!<Space>', nOpts)

keymap('n', 'ss', ':Obsession<CR>', nOpts)
keymap('n', 'sf', ':w<CR>', nOpts)
keymap('n', 'se', ':wqa<CR>', nOpts)
keymap('n', 'sn', ':q!<CR>', nOpts)
keymap('n', 'sj', ':wincmd j<CR>', nOpts)
keymap('n', 'sk', ':wincmd k<CR>', nOpts)
keymap('n', 'sh', ':wincmd h<CR>', nOpts)
keymap('n', 'sl', ':wincmd l<CR>', nOpts)

keymap('n', 'tj', ':tabnext<CR>', nsOpts)
keymap('n', 'tk', ':tabprevious<CR>', nsOpts)
keymap('n', 'tn', ':tabclose<CR>', nsOpts)
keymap('n', 'th', ':tabmove -1<CR>', nsOpts)
keymap('n', 'tl', ':tabmove +1<CR>', nsOpts)
keymap('n', 'to', ':CtrlPCurWD<CR>', nOpts)

keymap('n', 'yp', ':let @+ = expand("%")<CR>', nOpts)
keymap('n', 'yn', ':let @+ = expand("%:t")<CR>', nOpts)

keymap('n', '<esc>', ':noh<CR>', nsOpts)
keymap('n', '*', ':keepjumps normal! mi*`i<CR>', nsOpts)

vim.g.neoformat_try_node_exe = 1
vim.api.nvim_create_autocmd(
  { 'BufWritePre' },
  {
    pattern = { '*.ts', '*.js', '*.html', '*.md' },
    command = 'Neoformat',
  }
)

vim.g.ctrlp_use_caching = 0
vim.g.ctrlp_user_command = 'rg %s --files --color=never --glob ""'
vim.cmd [[ 
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
      \ 'AcceptSelection("t")': ['<cr>'],
      \ }
]]

vim.g.ackprg = "rg --vimgrep --type-not sql --type-not vim --smart-case"
vim.g.ack_use_cword_for_empty_search = 1
vim.cmd [[ 
cnoreabbrev Ack Ack!
]]
-- vim.g.ack_autoclose = 1

-- GitGutter
vim.g.gitgutter_diff_base = 'gamma'
vim.g.gitgutter_grep = 'rg'
vim.api.nvim_create_autocmd({ 'BufWritePost' }, { command = 'GitGutter' })

vim.api.nvim_create_autocmd({ 'BufEnter' }, { command = 'EnableBlameLine' })

vim.g.rustfmt_autosave = 1

-- noremap <leader>j :%!python -m json.tool<CR>

require('go').setup()
local function formatGo()
	require("go.format").goimport()  -- goimport + gofmt
end

vim.api.nvim_create_autocmd({ 'BufWritePre' }, { pattern = { '*.go' }, callback = formatGo })


