require('plugins')
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- base
vim.opt.list = true
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.termguicolors = true
vim.opt.pumblend = 10
vim.opt.winblend = 10
