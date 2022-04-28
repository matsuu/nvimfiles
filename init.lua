require('plugins')

-- base
vim.opt.list = true
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

if vim.env.TERM_PROGRAM ~= 'Apple_Terminal' then
	vim.opt.termguicolors = true
	vim.opt.pumblend = 10
	vim.opt.winblend = 10
end

-- For PaperColor colorscheme
vim.opt.background = "dark"
