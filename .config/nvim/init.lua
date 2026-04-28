require("config.lazy")

vim.o.scrolloff = 999
vim.o.foldlevel = 99

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = false

vim.g.mapleader = " "

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.clipboard = 'unnamedplus'
if vim.env.SSH_TTY ~= nil then
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
      ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
  }
end
vim.opt.cursorline = true

local keymap = vim.keymap.set
local nOpts = { noremap = true }
local nsOpts = { noremap = true, silent = true }

keymap('n', 'cj', function()
  require('gitsigns').nav_hunk('next')
end, nOpts)
keymap('n', 'ck', function()
  require('gitsigns').nav_hunk('prev')
end, nOpts)
keymap('n', 'ch', function()
  require('gitsigns').preview_hunk()
end, nOpts)
keymap('n', 'cc', '<cmd>CodeCompanionActions<CR>', nOpts)

keymap('n', 'gj', ':+10<CR>', nsOpts)
keymap('n', 'gk', ':-10<CR>', nsOpts)
keymap('n', 'gb', '<c-o>', nOpts)
keymap('n', 'go', '<cmd>Telescope find_files<CR>', nOpts)

keymap('n', 'ss', '<cmd>Obsession<CR>', nOpts)
keymap('n', 'sf', '<cmd>w<CR>', nOpts)
keymap('n', 'se', '<cmd>wqa<CR>', nOpts)
keymap('n', 'sn', '<cmd>q!<CR>', nOpts)
keymap('n', 'sj', '<cmd>wincmd j<CR>', nOpts)
keymap('n', 'sk', '<cmd>wincmd k<CR>', nOpts)
keymap('n', 'sh', '<cmd>wincmd h<CR>', nOpts)
keymap('n', 'sl', '<cmd>wincmd l<CR>', nOpts)
keymap('n', 'sm', '<cmd>tab split<CR>', nOpts)

keymap('n', 'tj', '<cmd>BufferNext<CR>', nsOpts)
keymap('n', 'tk', '<cmd>BufferPrevious<CR>', nsOpts)
keymap('n', 'tl', '<cmd>BufferMoveNext<CR>', nsOpts)
keymap('n', 'th', '<cmd>BufferMovePrevious<CR>', nsOpts)
keymap('n', 'tn', '<cmd>BufferClose<CR>', nsOpts)
vim.keymap.set('n', 'td', function()
  vim.cmd('tabnew')
  vim.cmd('DBUI')
end, { desc = 'Open DBUI in new tab' })

keymap('n', 'to', '<cmd>Telescope find_files<CR>', nOpts)
keymap('n', 'tg', '<cmd>Telescope live_grep<CR>', nOpts)

keymap('n', 'yp', ':let @+ = expand("%")<CR>', nOpts)
keymap('n', 'yn', ':let @+ = expand("%:t")<CR>', nOpts)

keymap('n', '<esc>', '<cmd>noh<CR>', nsOpts)
keymap('n', '*', '<cmd>keepjumps normal! mi*`i<CR>', nsOpts)

vim.api.nvim_create_autocmd({ 'BufEnter' }, { command = 'EnableBlameLine' })

vim.g.rustfmt_autosave = 1

vim.api.nvim_create_user_command('NumberLines', function()
  vim.cmd([[:'<,'>s/^/\=line('.') - line("'<") + 1 . '. '/]])
end, { range = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'c',
    'cs',
    'go',
    'html',
    'javascript',
    'lua',
    'markdown',
    'templ',
    'typescript',
    'vim',
    'vimdoc',
  },
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldmethod = 'expr'
  end,
})

-- Map Escape to exit terminal mode
vim.keymap.set('t', '<C-x>', '<C-\\><C-n>', { noremap = true })
