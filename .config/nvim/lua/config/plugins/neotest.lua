local M = {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-go",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
				}),
				require("neotest-go"),
			},
		})
		-- Keymaps
		local neotest = require("neotest")
		vim.keymap.set("n", "<leader>tn", neotest.run.run, { desc = "Test: Run nearest" })
		vim.keymap.set("n", "<leader>tf", function()
			neotest.run.run(vim.fn.expand("%"))
		end, { desc = "Test: Run file" })
		vim.keymap.set("n", "<leader>td", function()
			neotest.run.run({ strategy = "dap" })
		end, { desc = "Test: Debug nearest" })
		vim.keymap.set("n", "<leader>to", neotest.output.open, { desc = "Test: Show output" })
		vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, { desc = "Test: Toggle summary view" })
	end,
}

return { M }
