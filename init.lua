require('plugins')

-- base
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.list = true
vim.opt.mouse = 'a'
vim.opt.scrolloff = 4
vim.opt.swapfile = false

if vim.env.TERM_PROGRAM ~= 'Apple_Terminal' then
	vim.opt.termguicolors = true
	vim.opt.pumblend = 10
	vim.opt.winblend = 10
end

-- For PaperColor colorscheme
vim.opt.background = "dark"
