return {

	-- Highlight, edit, and navigate code
	{ "nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts  = {
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"latex",
				"lua",
				"luadoc",
				"python",
				"vim",
				"vimdoc",
			},
			sync_install = false,

			-- Autoinstall languages that are not installed
			-- Set `auto_install = false` if you do not have `tree-sitter-cli` installed locally
			auto_install = true,
			highlight    = {
				enable   = true,
				disable  = { "tex", "latex" },

				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				-- So, if you are experiencing weird indenting issues, add the language to
				-- the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},

		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		config = function(_, opts)

			-- Prefer git instead of curl in order to improve connectivity in some environments
			require("nvim-treesitter.install").prefer_git = true
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
