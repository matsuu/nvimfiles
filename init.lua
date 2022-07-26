require('plugins')

-- for FVim and Neovide
vim.opt.guifont = 'UDEV Gothic:h12'
vim.opt.guifontwide = 'UDEV Gothic:h12'

-- base
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.list = true
vim.opt.scrolloff = 4

if vim.env.TERM_PROGRAM ~= 'Apple_Terminal' then
	vim.opt.termguicolors = true
	vim.opt.pumblend = 10
	vim.opt.winblend = 10
end

-- For PaperColor colorscheme
vim.opt.background = "light"
