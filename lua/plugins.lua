local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

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

  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-web-devicons'

  use 'fgsch/vim-varnish'
  use 'mattn/vim-goimports'

  use 'cormacrelf/vim-colors-github'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
