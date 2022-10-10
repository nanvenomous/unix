vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use { 'williamboman/mason.nvim' }

	use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'

	use { 'pineapplegiant/spaceduck', branch = 'main' }

	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	use 'raimondi/delimitmate'
	use 'kien/ctrlp.vim'
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use 'tpope/vim-obsession'
	use 'airblade/vim-gitgutter'
end)
