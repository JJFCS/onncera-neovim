return {

	"neovim/nvim-lspconfig",
		-- Automatically install LSPs and related tools to stdpath for Neovim
		dependencies = {
			{ "williamboman/mason.nvim", config = true },  -- NOTE: must be loaded before dependants
			  "williamboman/mason-lspconfig.nvim",
			  "WhoIsSethDaniel/mason-tool-installer.nvim",
			  "hrsh7th/cmp-buffer",
			  "hrsh7th/cmp-cmdline",
			  "hrsh7th/cmp-nvim-lsp",
			  "hrsh7th/cmp-path",
			  "hrsh7th/nvim-cmp",
			  "L3MON4D3/LuaSnip",
			  "saadparwaiz1/cmp_luasnip",
			  "j-hui/fidget.nvim",
		},


		config = function()

			require("fidget").setup({})  -- useful status updates for LSP

			-- As it is, Neovim does not support everything that is in the LSP specification.
			-- As you add nvim-cmp, luasnip, etc.. Neovim now has *more* capabilities.
			-- So, we create new capabilities with nvim-cmp, and then broadcast that to the servers

			local cmp_lsp      = require("cmp_nvim_lsp")

			-- merges recursively two or more map-like tables
			-- behavior of 'force' is to use value from the rightmost map if a key is found in more than one map
			-- pass two or more map-like tables
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)


			--  Add any additional override configuration in the following tables
			--  Available keys are:
			--  - cmd          (table): Override the default command used to start the server
			--  - filetypes    (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities
			--                          Can be used to disable certain LSP features.
			--  - settings     (table): Override the default settings passed when initializing the server.
			local servers = {

				clangd = {
					filetypes = { "c", "cpp" },
				},
				lua_ls = {
					-- cmd          = {...},
					-- filetypes    = {...},
					-- capabilities = {...},
					settings = {
						Lua  = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = { globals = { "vim" } }, -- Tells LSP that 'vim' is part of your global namespace
						},
					},
				},
				texlab = {},
			}
			local ensure_installed = vim.tbl_keys(servers or {})

			require("mason").setup()
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- Handles overriding only values explicitly passed by the server configuration above.
						-- Helpful when disabling certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})


			-- LSP provides Neovim with features like:
			--		Go to definition, find references, autocompletion, symbol search, and much more!


			-- Function gets activated when an LSP attaches to a particular buffer.
			-- Every time a new file is opened that is associated with an LSP.
			-- For example, opening `main.rs` is associated with `rust_analyzer`... the function will
			--		be executed to configure the current buffer

			-- Setting up an LspAttach autocmd to ensure they are only
			-- active if there is an LSP client running (:help lsp-config)
			vim.api.nvim_create_autocmd('LspAttach', {
				group    = vim.api.nvim_create_augroup("onncera-lsp-attach", {}),
				callback = function(event)

					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					--[[
				
						EXPLANATION FOR CERTAIN LSP KEYMAPS

						Goto Implementation:
						useful when your language has ways of declaring types without an actual implementation
						-------------------------------------------------------

						Type Definition:
							useful when you're not sure what type a variable is and you want to see
							the definition of its *type*, not where it was *defined*.
						-------------------------------------------------------

						Symbols:
						Fuzzy find all the symbols in your current (document) / (workspace)
						For workspace, searches over your entire project
						Symbols are things like variables, functions, types, etc
						-------------------------------------------------------

						Rename
						Rename the variable under your cursor
						Most Language Servers support renaming across files, etc
						-------------------------------------------------------

						Code Action
							execute a code action, usually your cursor needs to be on top of an error
							or a suggestion from your LSP for this to activate
						-------------------------------------------------------

						To jump back, press <C-t>
						-------------------------------------------------------

					--]]

					map("gd", require("telescope.builtin").lsp_definitions,     "[G]oto [D]efinition"    )
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("gr", require("telescope.builtin").lsp_references,      "[G]oto [R]eferences"    )

					map("gD", vim.lsp.buf.declaration,                          "[G]oto [D]eclaration"   )

					map("<leader>D",  require("telescope.builtin").lsp_type_definitions,          "Type [D]efinition"    )
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols,          "[D]ocument [S]ymbols" )
					map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

					map("<leader>ca", vim.lsp.buf.code_action,                                    "[C]ode [A]ction"      )
					map("<leader>rn", vim.lsp.buf.rename,                                         "[R]e[n]ame"           )

					map("K",          vim.lsp.buf.hover,                                          "Hover Documentation"  )


					-- Following two autocommands are used to highlight references of the word
					--		under your cursor when your cursor rests there for a while.
					-- See `:help CursorHold` for information about when this is executed
					-- Highlights will be cleared upon moving your cursor (the 2nd autocommand)

					local client = vim.lsp.get_client_by_id(event.data.client_id)  -- stores the current LSP event client ID in a variable
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup = vim.api.nvim_create_augroup("onncera-lsp-highlight", { clear = false })  -- set clear to false as to not remove the existing commands

						-- 1st autocommand
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer   = event.buf,
							group    = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						-- 2nd autocommand
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer   = event.buf,
							group    = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
					end


					-- Following autocommand is used to enable inlay hints in your
					-- code, if the language server you are using supports them
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})


			vim.api.nvim_create_autocmd("LspDetach", {
				group    = vim.api.nvim_create_augroup("onncera-lsp-detach", { clear = true }),
				callback = function(event)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "onncera-lsp-highlight", buffer = event.buf })
				end,
			})
		end
}
