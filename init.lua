require('jetpack').startup(function(use)
  use'cormacrelf/vim-colors-github'
  use'hrsh7th/nvim-cmp'
  use'hrsh7th/cmp-nvim-lsp'
  use'hrsh7th/cmp-buffer'
  use'hrsh7th/cmp-path'
  use'hrsh7th/cmp-cmdline'
  use'hrsh7th/cmp-nvim-lsp-signature-help'
  use'mattn/vim-goimports'
  use'neovim/nvim-lspconfig'
  use'williamboman/nvim-lsp-installer'
end)

vim.opt.list = true
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.termguicolors = true
vim.opt.pumblend = 10
vim.opt.winblend = 10
-- vim.opt.background = 'light'

vim.cmd('colorscheme github')

vim.g.goimports_simplify = 1

local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset,
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'nvim_lsp_signature_help' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_installer = require('nvim-lsp-installer')

lsp_installer.on_server_ready(function(server)
  server:setup({ capabilities = capabilities })
end)
