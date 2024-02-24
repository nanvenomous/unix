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
  use { 'nvim-treesitter/nvim-treesitter-context' }

  -- git
  use { 'airblade/vim-gitgutter' }

  use 'sbdchd/neoformat'

  use 'raimondi/delimitmate'
  use 'kien/ctrlp.vim'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-obsession'
  use 'mileszs/ack.vim'

  use 'tveskag/nvim-blame-line'

  -- LLM
  use 'gsuuon/model.nvim'

  -- Rust
  use 'simrat39/rust-tools.nvim'

  -- GO
  use 'ray-x/go.nvim'
  use 'ray-x/guihua.lua' -- recommanded if need floating window support

end)

