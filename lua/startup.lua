
require("onncera.options")
require("onncera.remaps")


-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
	spec =  { import = "extensions" },
	change_detection = { notify = false }
})


-- [[ Configure and install plugins ]]
--    Check the current status of your plugins, run
--    :Lazy
--
--  Press `?` in this menu for help, use `:q` to close the window
--  Press `:Lazy update`
--  NOTE: Plugin installation (here is where you can do it)
--  NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).


	-- NOTE: Plugins can also be added by using a table
	-- The first argument being the link
	-- The following keys can be used to configure plugin behavior/loading/etc.
	--
	-- To force a plugin to be loaded, use `opts = {}`
	-- This is equivalent to: "require('Comment').setup({})"


	-- "gc" to comment visual regions/lines
	-- { "numToStr/Comment.nvim", opts = {} },


	-- Here is a more advanced example where we pass configuration
	-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
	-- require('gitsigns').setup({ ... })
	--
	-- See `:help gitsigns` to understand what the configuration keys do.
	-- Adds git related signs to the gutter, as well as utilities for managing changes
	-- { "lewis6991/gitsigns.nvim", opts = { signs = {
	-- 			add          = { text = "+" },
	-- 			change       = { text = "~" },
	-- 			delete       = { text = "_" },
	-- 			topdelete    = { text = "‾" },
	-- 			changedelete = { text = "~" },
	-- 		},
	-- 	},
	-- },

