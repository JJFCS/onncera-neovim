-- Onncera's personal remaps


-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader      = " "
vim.g.maplocalleader = ","


-- [[ Basic Keymaps ]]
--    See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Good ol' emacs coming to the rescue
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d",        vim.diagnostic.goto_prev,  { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d",        vim.diagnostic.goto_next,  { desc = "Go to next [D]iagnostic message"     })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages"    })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list"     })

-- CTRL+<hjkl> to switch between windows
-- See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window"  })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Make split navigation easier
vim.keymap.set("n", "<leader>wv", "<C-w>v",         { desc = "Split window vertically"   })
vim.keymap.set("n", "<leader>wh", "<C-w>s",         { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>we", "<C-w>=",         { desc = "Split window equal size"   })
vim.keymap.set("n", "<leader>wq", "<cmd>close<CR>", { desc = "Close current split"       })


-- [[ Basic Autocommands ]]
--    See `:help lua-guide-autocommands`

-- Yanking (copying) text will show highlights
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc     = "Highlight when yanking (copying) text",
	group    = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

