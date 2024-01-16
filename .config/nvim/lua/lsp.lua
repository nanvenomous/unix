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
-- autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

-- nnoremap <silent> tf <cmd>tab split \| lua vim.lsp.buf.definition()<cr>
-- nnoremap <silent>ge <cmd>lua require("echo-diagnostics").echo_entire_diagnostic()<CR>

local function organize_imports()
    vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})
end

local function show_diagnostic()
	vim.diagnostic.open_float(nil, { focusable = false })
end
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gf', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gu', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', 'ge', show_diagnostic, bufopts)
	vim.keymap.set('n', 'gl', organize_imports, bufopts)

end

-- Setup lspconfig.
local servers = { 'gopls', 'pyright', 'tsserver', 'rust_analyzer', 'kotlin_language_server' }
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

-- gopls, pyright, typescript-language-server, rust-analyzer, lua-language-server
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

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

require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}
