return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- autocomplete
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  -- colorscheme
  use 'RRethy/nvim-base16'

  -- statusline
  use 'nvim-lualine/lualine.nvim'

  -- filetypes
  use {
    'fgsch/vim-varnish',
    opt = true,
    ft = {'vcl'},
  }
  use {
    'mattn/vim-goimports',
    opt = true,
    ft = {'go'},
  }
end)
