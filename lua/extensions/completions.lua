return {

	-- Snippet Engine (snippets are recommendations you get based off of previous code)
	{ "L3MON4D3/LuaSnip",

		-- Build step is needed for regex support in snippets
		build        = "make install_jsregexp",
		dependencies = {
			-- contains a variety of premade snippets.
			-- See the README about individual language/framework/plugin snippets: https://github.com/rafamadriz/friendly-snippets
			{ 'rafamadriz/friendly-snippets',
				config = function()
					require('luasnip.loaders.from_vscode').lazy_load()
				end,
			},
		},
	},


	{ "hrsh7th/nvim-cmp",
		event  = "InsertEnter",
		-- See `:help cmp`
		config = function()
			local cmp     = require('cmp')
			local luasnip = require('luasnip')
			luasnip.config.setup({})

			-- Global setup.
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)  -- For `luasnip` users
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),  -- Select the [n]ext item
					["<C-p>"] = cmp.mapping.select_prev_item(),  -- Select the [p]rev item

					-- Scroll the documentation window [b]ack / [f]orward
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- Accept ([y]es) the completion.
					-- ~ This will auto-import if your LSP supports it.
					-- ~ This will expand snippets if the LSP sent a snippet.
					["<C-y>"] = cmp.mapping.confirm({ select = true }),

					-- Manually trigger a completion from nvim-cmp.
					["<C-Space>"] = cmp.mapping.complete({}),


					-- <c-l> moves you to the right of your snippet expansion.
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),

					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),

				-- unable to place cmp-cmdline in global setup as the completion source
				-- gets polluted with neovim variables/functions
				-- Hence, we add cmp-cmdline in its own setup function
				sources = {
					{ name = 'buffer'   },
					{ name = 'luasnip'  },
					{ name = 'nvim_lsp' },
					{ name = 'path'     },
				},
			})
		end
	},


	{ "hrsh7th/cmp-cmdline",
		config = function()

			local cmp = require('cmp')

			-- Completions for `/` search based on the current buffer
			cmp.setup.cmdline('/', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})


			-- Completions for command mode
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' },
					{ name = 'cmdline' },
				})
			})
		end
	},
}
