require("config.lazy")

vim.o.scrolloff = 999

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = false

vim.g.mapleader = " "

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
keymap('n', 'cc', ':CodeCompanionActions<CR>', nOpts)
-- nnoremap db :let g:gitgutter_diff_base = 'mainline'<CR>
-- nnoremap di :let g:gitgutter_diff_base = 'head'<CR>

keymap('n', 'gj', ':+10<CR>', nsOpts)
keymap('n', 'gk', ':-10<CR>', nsOpts)
keymap('n', 'gb', '<c-o>', nOpts)
keymap('n', 'gs', ':Ack!<Space>', nOpts)
keymap('n', 'go', ':Telescope find_files<CR>', nOpts)

keymap('n', 'ss', ':Obsession<CR>', nOpts)
keymap('n', 'sf', ':w<CR>', nOpts)
keymap('n', 'se', ':wqa<CR>', nOpts)
keymap('n', 'sn', ':q!<CR>', nOpts)
keymap('n', 'sj', ':wincmd j<CR>', nOpts)
keymap('n', 'sk', ':wincmd k<CR>', nOpts)
keymap('n', 'sh', ':wincmd h<CR>', nOpts)
keymap('n', 'sl', ':wincmd l<CR>', nOpts)
keymap('n', 'sm', ':tab split<CR>', nOpts)

keymap('n', 'tj', ':BufferNext<CR>', nsOpts)
keymap('n', 'tk', ':BufferPrevious<CR>', nsOpts)
keymap('n', 'tl', ':BufferMoveNext<CR>', nsOpts)
keymap('n', 'th', ':BufferMovePrevious<CR>', nsOpts)
keymap('n', 'tn', ':BufferClose<CR>', nsOpts)
vim.keymap.set('n', 'td', function()
  vim.cmd('tabnew')
  vim.cmd('DBUI')
end, { desc = 'Open DBUI in new tab' })

keymap('n', 'to', ':Telescope find_files<CR>', nOpts)
keymap('n', 'tg', ':Telescope live_grep<CR>', nOpts)

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

-- GitGutter
-- vim.g.gitgutter_diff_base = 'gamma'
-- vim.g.gitgutter_diff_base = 'v0.0.49'
-- vim.g.gitgutter_diff_base = 'HEAD~1'
vim.g.gitgutter_grep = 'rg'
vim.api.nvim_create_autocmd({ 'BufWritePost' }, { command = 'GitGutter' })
vim.api.nvim_create_autocmd({ 'BufEnter' }, { command = 'EnableBlameLine' })

vim.g.rustfmt_autosave = 1

vim.api.nvim_create_user_command('NumberLines', function()
  vim.cmd([[:'<,'>s/^/\=line('.') - line("'<") + 1 . '. '/]])
end, { range = true })

-- require("go.format").goimports()  -- goimports + gofmt

-- Map Escape to exit terminal mode
vim.keymap.set('t', '<C-x>', '<C-\\><C-n>', { noremap = true })
