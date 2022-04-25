vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	-- autocomplete
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-vsnip',
			'hrsh7th/vim-vsnip',
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'neovim/nvim-lspconfig',
		},
		config = function()
			local cmp = require('cmp')
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn['vsnip#anonymous'](args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
				}),
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
		end,
	}
	use {
		'williamboman/nvim-lsp-installer',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'lukas-reineke/lsp-format.nvim',
		},
		config = function()
			local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
			require('lsp-format').setup {}
			local on_attach = require('lsp-format').on_attach

			local opts = {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' },
						},
					}
				}
			}

			local lsp_installer = require('nvim-lsp-installer')
			lsp_installer.on_server_ready(function(server)
				server:setup(opts)
			end)
		end,
	}

	-- colorscheme
	use {
		'yorik1984/newpaper.nvim',
		config = function()
			require('newpaper').setup({
				style = 'dark',
				disable_background = true,
			})
		end,
	}

	-- statusline
	use {
		'nvim-lualine/lualine.nvim',
		config = function()
			vim.opt.showmode = false
			require('lualine').setup {
				options = {
					theme = 'PaperColor',
					icons_enabled = false,
					component_separators = '',
					section_separators = '',
				},
			}
		end,
	}

	-- filetypes
	use { 'fgsch/vim-varnish', opt = true, ft = { 'vcl' } }

	-- git
	use {
		'sindrets/diffview.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('diffview').setup()
		end,
	}
end)
