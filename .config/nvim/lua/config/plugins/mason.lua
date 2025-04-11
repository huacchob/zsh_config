local M = {
	"williamboman/mason.nvim",
	lazy = false,
	priority = 1000,
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- ✅ no mason-lspconfig here
	},
	config = function()
		local mason = require("mason")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
				"pylint",
				"mypy",
				"eslint_d",
				"shellharden",
				"ruff",
			},
		})
	end,
}

return { M }
