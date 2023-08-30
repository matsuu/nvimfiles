vim.api.nvim_create_autocmd('BufWritePost', {
	group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
	pattern = 'plugins.lua',
	command = 'source <afile> | PackerCompile',
})

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	-- autocomplete
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lua',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lsp-signature-help',
		},
		config = function()
			local cmp = require('cmp')
			if cmp == nil then
				return
			end
			local luasnip = require('luasnip')
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
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
					['<CR>'] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lua' },
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
		'williamboman/mason-lspconfig.nvim',
		after = 'nvim-cmp',
		requires = {
			'williamboman/mason.nvim',
			'lukas-reineke/lsp-format.nvim',
			'neovim/nvim-lspconfig',
		},
		config = function()
			local settings = {
				sumneko_lua = {
					Lua = {
						runtime = {
							version = 'LuaJIT',
						},
						diagnostics = {
							globals = { 'vim' },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
						completion = {
							callSnippet = 'Replace',
						},
					},
				},
				gopls = {
					gopls = {
						usePlaceholders = true,
					},
				},
			}

			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local lsp_format = require('lsp-format')
			lsp_format.setup {}

			local on_attach = function(client)
				lsp_format.on_attach(client)
			end

			require('mason').setup {}
			local mason_lspconfig = require('mason-lspconfig')
			mason_lspconfig.setup {}

			for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
				-- local target = server.name
				local target = server
				require('lspconfig')[target].setup {
					capabilities = capabilities,
					on_attach = on_attach,
					settings = settings[target],
				}
			end
		end,
	}

	-- lsp progress
	use {
		'j-hui/fidget.nvim',
		tag = 'legacy',
		config = function()
			require('fidget').setup {}
		end,
	}

	use {
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require('nvim-treesitter.configs').setup {
				highlight = {
					enable = true,
				},
			}
		end,
	}

	-- trouble
	use {
		'folke/trouble.nvim',
		config = function()
			require("trouble").setup {
				height = 4,
				padding = false,
			}
		end,
	}

	-- terminal
	use {
		'akinsho/toggleterm.nvim',
		config = function()
			require('toggleterm').setup()
		end,
	}

	use {
		'RRethy/nvim-base16',
		config = function()
			vim.cmd 'colorscheme base16-tomorrow'
		end,
	}

	-- font
	use 'kyazdani42/nvim-web-devicons'

	-- statusline
	use {
		'nvim-lualine/lualine.nvim',
		config = function()
			vim.opt.showmode = false
			require('lualine').setup {
				options = {
					theme = 'base16',
				},
			}
		end,
	}

	-- filetypes
	use { 'varnishcache-friends/vim-varnish', opt = true, ft = { 'vcl' } }

	-- git
	use {
		'sindrets/diffview.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('diffview').setup {
				file_panel = {
					win_config = {
						position = 'top',
						height = 4,
					},
				},
				file_history_panel = {
					win_config = {
						height = 4,
					},
				}
			}
		end,
	}
end)
