return {

	'ThePrimeagen/harpoon',
		branch       = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config       = function()
			local harpoon = require("harpoon")

			-- REQUIRED
			harpoon:setup()
			-- REQUIRED

			vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,                         { desc = "HP insert current buf. into list" })
			vim.keymap.set("n", "<C-e>",     function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "HP toggle menu" })

			vim.keymap.set("n", "<M-d>", function() harpoon:list():select(1) end, { desc = "HP access item 1" })
			vim.keymap.set("n", "<M-f>", function() harpoon:list():select(2) end, { desc = "HP access item 2" })
			vim.keymap.set("n", "<M-h>", function() harpoon:list():select(3) end, { desc = "HP access item 3" })
			vim.keymap.set("n", "<M-j>", function() harpoon:list():select(4) end, { desc = "HP access item 4" })
			vim.keymap.set("n", "<leader><M-d>", function() harpoon:list():replace_at(1) end, { desc = "HP make current buf. item 1" })
			vim.keymap.set("n", "<leader><M-f>", function() harpoon:list():replace_at(2) end, { desc = "HP make current buf. item 2" })
			vim.keymap.set("n", "<leader><M-h>", function() harpoon:list():replace_at(3) end, { desc = "HP make current buf. item 3" })
			vim.keymap.set("n", "<leader><M-j>", function() harpoon:list():replace_at(4) end, { desc = "HP make current buf. item 4" })
		end
}
