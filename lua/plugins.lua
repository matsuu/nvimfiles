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
			'hrsh7th/cmp-nvim-lsp',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'neovim/nvim-lspconfig',
		},
		config = function()
			local cmp = require('cmp')
			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
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
					{ name = 'luasnip' },
					{ name = 'nvim_lsp_signature_help' },
				})
			})
			vim.diagnostic.config({
				virtual_text = false,
				-- signs = false,
				-- underline = false,
				-- update_in_insert = true,
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

	use {
		'folke/trouble.nvim',
		config = function()
			require("trouble").setup {
				height = 4,
				icons = false,
				fold_open = "v",
				fold_closed = ">",
				padding = false,
				auto_open = false,
				auto_close = true,
				signs = {
					-- icons / text used for a diagnostic
					error = "Error",
					warning = "Warn",
					hint = "Hint",
					information = "Info",
					other = "Other",
				},
			}
		end,
	}

	-- colorscheme
	use {
		'NLKNguyen/papercolor-theme',
		setup = function()
			vim.g.PaperColor_Theme_Options = {
				theme = {
					default = {
						-- transparent_background = 1,
						allow_bold = 1,
						allow_italic = 1,
					},
				}
			}
		end,
		config = function()
			vim.cmd([[colorscheme PaperColor]])
		end,
	}

	-- statusline
	use {
		'nvim-lualine/lualine.nvim',
		config = function()
			vim.opt.showmode = false
			require('lualine').setup {
				options = {
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
