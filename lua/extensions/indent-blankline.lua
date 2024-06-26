return {

	"lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {},

		config = function()

			local highlight = {
				"Color1",          -- rainbow red
				"Color2",          -- rainbow yellow
				"Color3",          -- rainbow blue
				"Color4",          -- rainbow orange
				"Color5",          -- rainbow green
				"Color6",          -- rainbow violet
				"Color7",          -- rainbow cyan
			}

			local hooks = require "ibl.hooks"
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "Color1",    { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "Color2",    { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "Color3",    { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "Color4",    { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "Color5",    { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "Color6",    { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "Color7",    { fg = "#56B6C2" })
			end)

			require("ibl").setup{
				indent = { highlight = highlight },
				scope  = { highlight = highlight, show_start = true, show_end = true },
			}
		end
}
