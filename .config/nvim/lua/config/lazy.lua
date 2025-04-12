-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

-- local libero_api_key = os.getenv("LIBERO_API_KEY")
local home = os.getenv("HOME")

require("lazy").setup({
   spec = {
    {
      "neanias/everforest-nvim",
      version = false,
      lazy = false,
      priority = 1000, -- make sure to load this before all the other start plugins
      -- Optional; default configuration will be used if setup isn't called.
      config = function()
        require("everforest").setup({
          -- Your config here
        })
      end,
    },
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            -- ensure_installed = { "c", "lua", "go", "typescript", "vim", "html" },
            ensure_installed = { "go", "typescript", "html", "templ", "c", "lua", "vim", "html" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
      end
     },

    { 'nvim-treesitter/nvim-treesitter-context' },
    { 'neovim/nvim-lspconfig' }, -- Configurations for Nvim LSP
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/vim-vsnip' },

    { 'airblade/vim-gitgutter' },
    { 'raimondi/delimitmate' },
    { 'tpope/vim-obsession' },
    { 'tpope/vim-surround' },
    { 'tpope/vim-commentary' },
    { 'mileszs/ack.vim' },
    { 'tveskag/nvim-blame-line' },
    { 'ray-x/go.nvim' },
    { 'ray-x/guihua.lua' }, -- recommanded if need floating window support
    { 'sbdchd/neoformat' },
    {
      "yetone/avante.nvim",
      event = "VeryLazy",
      version = false, -- Never set this value to "*"! Never!
      opts = {
        -- add any opts here
        -- for example
        provider = "ollama",
        ollama = {
          -- model = "deepseek-r1:32b",
          model = "deepseek-coder-v2:16b",
          -- api_key_name = "LIBERO_API_KEY",
          -- endpoint = "https://ollama.fiore.one",
          -- parse_curl_args = function(opts, code_opts)
          --   return {
          --     url = opts.endpoint .. "/chat/completions",
          --     headers = {
          --       ["Accept"] = "application/json",
          --       ["Content-Type"] = "application/json",
          --       ["Key"] = libero_api_key,
          --     },
          --     body = {
          --       model = opts.model,
          --       messages = require("avante.providers").copilot.parse_messages(code_opts), -- you can make your own message, but this is very advanced
          --       max_tokens = 2048,
          --       stream = true,
          --     },
          --   }
          -- end,
        },
      },
      -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
      build = "make",
      -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "echasnovski/mini.pick", -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        "ibhagwan/fzf-lua", -- for file_selector provider fzf
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        -- "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
          -- Make sure to set this up properly if you have lazy=true
          'MeanderingProgrammer/render-markdown.nvim',
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        },
      },
    },
  },
  checker = { enabled = true },
})

local cmp = require'cmp'

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
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
		{ name = 'vsnip' },
		{ name = 'buffer' },
	}
})
-- LSP Diagnostics Options Setup 
local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = ''
	})
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	update_in_insert = true,
	underline = true,
	severity_sort = false,
	float = {
		border = 'rounded',
		source = 'always',
		header = '',
		prefix = '',
	},
})

vim.cmd([[
set signcolumn=yes
]])

vim.filetype.add({ extension = { templ = "templ" } })

local custom_format = function()
    if vim.bo.filetype == "templ" then
        local bufnr = vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local cmd = "templ fmt " .. vim.fn.shellescape(filename)

        vim.fn.jobstart(cmd, {
            on_exit = function()
                -- Reload the buffer only if it's still the current buffer
                if vim.api.nvim_get_current_buf() == bufnr then
                    vim.cmd('e!')
                end
            end,
        })
    else
        vim.lsp.buf.format()
    end
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.go", "*.templ" }, callback = custom_format })


local function show_diagnostic()
	vim.diagnostic.open_float(nil, { focusable = false })
end
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gf', function() require('telescope.builtin').lsp_document_symbols({ symbols = {'function', 'method'} }) end, bufopts)
  vim.keymap.set('n', 'gv', function() require('telescope.builtin').lsp_document_symbols({ symbols = {'variable', 'constant', 'struct'} }) end, bufopts)
	vim.keymap.set('n', 'gu', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', 'ge', show_diagnostic, bufopts)
	vim.keymap.set('n', 'gl', custom_format, bufopts)
end

-- Setup lspconfig.
local servers = { 'gopls', 'pyright', 'ts_ls', 'rust_analyzer', 'kotlin_language_server', 'templ', 'tailwindcss' }
local nvim_lsp = require('lspconfig')
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }
end

nvim_lsp.lua_ls.setup({
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150,
	},
	settings = {
		Lua = {
			diagnostics = { globals = { 'vim' } }
		}
	}
})

-- Setup nvim-treesitter
-- require'nvim-treesitter.configs'.setup {
--     ensure_installed = { "c", "lua", "go", "typescript" },
--     auto_install = true,
--     highlight = {
--         enable = true,
--         additional_vim_regex_highlighting = true,
--     },
--     indent = {
--         enable = true
--     },
-- }

-- require'treesitter-context'.setup{
--   enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
--   max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
--   min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
--   line_numbers = true,
--   multiline_threshold = 20, -- Maximum number of lines to show for a single context
--   trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
--   mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
--   -- Separator between context and content. Should be a single character string, like '-'.
--   -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
--   separator = nil,
--   zindex = 20, -- The Z-index of the context window
--   on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
-- }


nvim_lsp.html.setup({
  on_attach = on_attach,
  filetypes = { "html", "templ" },
})
nvim_lsp.htmx.setup({
  on_attach = on_attach,
  filetypes = { "html", "templ" },
})

local handle = io.popen('hostname')
Hostname = nil
if handle then
    Hostname = string.gsub(handle:read("*a"), "^%s+", "")
    handle:close()
    -- vim.notify(tostring(string.find(Hostname, "oddjobs")), vim.log.levels.INFO)
    -- vim.notify(string.format("Hostname: %s", Hostname), vim.log.levels.INFO)
end
