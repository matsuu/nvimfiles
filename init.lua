require('plugins')
vim.cmd([[
  augroup custom_papercolorslim_transparent_background
    autocmd!
    autocmd ColorScheme PaperColorSlim highlight Normal guibg=none
  augroup end
]])

-- base
vim.opt.list = true
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.pumblend = 10
vim.opt.winblend = 10
