local M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		require("mason-nvim-dap").setup({
		automatic_setup = true,
		automatic_installation = true,
		ensure_installed = {
			"debugpy", -- Python
		},
		})

		require("dapui").setup()
		require("dap-go").setup()
		require("dap-python").setup()
	end,
}

return { M }
