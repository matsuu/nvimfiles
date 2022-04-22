require('plugins')
require('autocomplete')
require('lualine').setup {
  options = {
    theme = 'material',
    icons_enabled = false,
    component_separators = '',
    section_separators = '',
  },
}
vim.cmd("colorscheme github")

-- base
vim.opt.list = true
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.termguicolors = true
vim.opt.pumblend = 10
vim.opt.winblend = 10
-- vim.opt.background = 'light'

vim.g.goimports_simplify = 1
