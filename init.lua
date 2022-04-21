vim.opt.list = true
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.termguicolors = true
vim.opt.pumblend = 10
vim.opt.winblend = 10
-- vim.opt.background = 'light'
--
require('plugins')

-- vim.cmd('colorscheme github')
require('xcode-colors').setup {
  background = "dynamic",
  -- extensions = { "treesitter" },
}

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
