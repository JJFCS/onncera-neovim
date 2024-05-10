
-- https://github.com/blazkowolf/gruber-darker.nvim
-- https://github.com/bluz71/vim-moonfly-colors
-- https://github.com/dgox16/oldworld.nvim
-- https://github.com/marko-cerovac/material.nvim
-- https://github.com/Mofiqul/vscode.nvim
-- https://github.com/navarasu/onedark.nvim
-- https://github.com/nyoom-engineering/oxocarbon.nvim
-- https://github.com/olimorris/onedarkpro.nvim
-- https://github.com/projekt0n/github-nvim-theme
-- https://github.com/rockerBOO/boo-colorscheme-nvim
-- https://github.com/sainnhe/gruvbox-material
-- https://github.com/sainnhe/sonokai
-- https://github.com/uncleTen276/dark_flat.nvim
-- https://github.com/Yazeed1s/minimal.nvim
-- https://github.com/Yazeed1s/oh-lucy.nvim

return {

	{
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"nyoom-engineering/oxocarbon.nvim",
			priority = 1000, -- Make sure to load this before all the other start plugins.
			init     = function()
				-- Load the colorscheme here.
				-- Like many other themes, this one has different styles, and you could load
				-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
				vim.cmd.colorscheme("oxocarbon")

				-- You can configure highlights by doing something like:
				vim.cmd.hi("Comment gui=none")
			end,
	},

}



--[[
return {

	{
		"ntk148v/komau.vim",
			priority = 1000, -- Make sure to load this before all the other start plugins.
			init     = function()

				vim.g.komau_italic = 0  -- disable italics
				vim.opt.background = "light"

				-- Load the colorscheme here.
				-- Like many other themes, this one has different styles, and you could load
				-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
				vim.cmd.colorscheme("komau")

				-- You can configure highlights by doing something like:
				vim.cmd.hi("Comment gui=none")
			end,
	},

}
--]]


