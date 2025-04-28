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

local libero_api_key = os.getenv("LIBERO_API_KEY")
local home = os.getenv("HOME")
local host = os.getenv("HOST")


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
            ensure_installed = {
            "go",
            "typescript", "javascript",
            "html",
            "templ",
            "c",
            "lua",
            "vim",
            "html",
            "c_sharp",
          },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
      end
     },
    {
      'nvim-treesitter/nvim-treesitter-context',
      opts = function()
        -- local tsc = require("treesitter-context")
        return {
          enable = true,
          mode = "cursor",
          max_lines = 5,
          multiline_threshold = 1,
        }
      end
    },
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
    { 'mfussenegger/nvim-dap' },
    { 'MeanderingProgrammer/render-markdown.nvim' },
    {
      'rcarriga/nvim-dap-ui',
      dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    },
    { 'leoluz/nvim-dap-go' },
    {
      'tpope/vim-dadbod',
      dependencies = { 'kristijanhusak/vim-dadbod-completion', 'kristijanhusak/vim-dadbod-ui' },
    },
    {
      'stevearc/oil.nvim',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {},
      -- Optional dependencies
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
      -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
      lazy = false,
    },
    {
      "olimorris/codecompanion.nvim",
      opts = {},
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
    },
    -- {
    --   "yetone/avante.nvim",
    --   event = "VeryLazy",
    --   version = false, -- Never set this value to "*"! Never!
    --   opts = {
    --     -- add any opts here
    --     -- for example
    --     provider = "ollama",
    --     ollama = {
    --       model = "deepseek-coder-v2:16b",
    --       api_key_name = "LIBERO_API_KEY",
    --       endpoint = "https://ollama.fiore.one",
    --       -- model = "deepseek-r1:32b",
    --       -- parse_curl_args = function(opts, code_opts)
    --       --   return {
    --       --     url = opts.endpoint .. "/chat/completions",
    --       --     headers = {
    --       --       ["Accept"] = "application/json",
    --       --       ["Content-Type"] = "application/json",
    --       --       ["Key"] = libero_api_key,
    --       --     },
    --       --     body = {
    --       --       model = opts.model,
    --       --       messages = require("avante.providers").copilot.parse_messages(code_opts), -- you can make your own message, but this is very advanced
    --       --       max_tokens = 2048,
    --       --       stream = true,
    --       --     },
    --       --   }
    --       -- end,
    --     },
    --   },
    --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    --   build = "make",
    --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    --   dependencies = {
    --     "nvim-treesitter/nvim-treesitter",
    --     "stevearc/dressing.nvim",
    --     "nvim-lua/plenary.nvim",
    --     "MunifTanjim/nui.nvim",
    --     --- The below dependencies are optional,
    --     "echasnovski/mini.pick", -- for file_selector provider mini.pick
    --     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    --     "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    --     "ibhagwan/fzf-lua", -- for file_selector provider fzf
    --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    --     -- "zbirenbaum/copilot.lua", -- for providers='copilot'
    --     {
    --       -- Make sure to set this up properly if you have lazy=true
    --       'MeanderingProgrammer/render-markdown.nvim',
    --       opts = {
    --         file_types = { "markdown", "Avante" },
    --       },
    --       ft = { "markdown", "Avante" },
    --     },
    --   },
    -- },
  },
  checker = { enabled = true },
})

require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "deepseek",
    },
    inline = {
      adapter = "deepseek",
    },
  },
  adapters = {
    llama3 = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "llama3", -- Give this adapter a different name to differentiate it from the default ollama adapter
        schema = {
          model = {
            default = "llama3.2",
          },
          num_ctx = {
            default = 16384,
          },
          num_predict = {
            default = -1,
          },
        },
      })
    end,
    deepseek = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "deepseek", -- Give this adapter a different name to differentiate it from the default ollama adapter
        schema = {
          model = {
            default = "deepseek-r1:14b",
          },
          num_ctx = {
            default = 16384,
          },
          num_predict = {
            default = -1,
          },
        },
      })
    end,
    remoteollama = function()
      return require("codecompanion.adapters").extend("ollama", {
        env = {
          -- url = "http://127.0.0.1:11434",
          -- url = "https://ollama.fiore.one",
          -- api_key = "OLLAMA_API_KEY",
          -- api_key = "LIBERO_API_KEY",
          api_key = libero_api_key,
        },
        headers = {
          ["Content-Type"] = "application/json",
          -- ["Authorization"] = libero_api_key,
          ["Authorization"] = "${api_key}",
        },
        parameters = {
          sync = true,
        },
      })
    end,
  },
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
    per_filetype = {
      codecompanion = { "codecompanion" },
    }
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
local servers = {
  'gopls',
  'pyright',
  'ts_ls',
  'rust_analyzer',
  'kotlin_language_server',
  'templ',
  'tailwindcss',
  'csharp_ls'
}
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

local dap, dapui = require('dap'), require('dapui')
local dapgo = require('dap-go')
dapui.setup()
dapgo.setup()
dap.listeners.before.attach.dapui_config = function()
 dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
 dapui.open()
end


-- Include the next few lines until the comment only if you feel you need it
dap.listeners.before.event_terminated.dapui_config = function()
 dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
 dapui.close()
end

-- vim.api.nvim_create_augroup("fmt", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = "fmt",
--   pattern = "*",
--   callback = function()
--     vim.cmd("undojoin | Neoformat")
--   end
-- })
-- Include everything after this


-- DAP SHORTCUTS --------------------------------------------------
-- vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
-- vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
-- vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
-- vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
-- vim.keymap.set('n', '<Leader>q', function()
-- require('dap').toggle_breakpoint() end)
-- vim.keymap.set('n', '<Leader>Q', function() require('dap').set_breakpoint()
-- end)
-- vim.keymap.set('n', '<Leader>lp', function()
-- require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
-- end)
-- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
-- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

-- vim.keymap.set('n', '<Leader>w', function() dapui.open() end)
-- vim.keymap.set('n', '<Leader>W', function() dapui.close() end)



-- DAP CSHARP --------------------------------------------------
-- local dap = require('dap')
-- dap.adapters.coreclr = {
--   type = 'executable',
--   command = home .. '/csharp/netcoredbg',
--   args = {'--interpreter=vscode'}
-- }
-- dap.configurations.cs = {
--   {
--     type = "coreclr",
--     name = "launch - netcoredbg",
--     request = "launch",
--     program = function()
--         return vim.fn.input(vim.fn.getcwd() .. '/bin/Debug/net8.0/')
--     end,
--   },
-- }
