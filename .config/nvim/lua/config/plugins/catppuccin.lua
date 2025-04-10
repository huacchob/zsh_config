local M = {
	"catppuccin/nvim",
	enabled = true,
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			background = {
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false,
			show_end_of_buffer = false, -- hide ~ at end of buffers
			term_colors = true,
			dim_inactive = {
				enabled = false,
				shade = "dark",
				percentage = 0.15,
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				telescope = {
					enabled = true,
				},
				notify = true,
				mini = true,
				which_key = true,
				treesitter = true,
				indent_blankline = {
					enabled = true,
					scope_color = "lavender", -- Catppuccin palette color
					colored_indent_levels = false,
				},
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				dap = {
					enabled = true,
					enable_ui = true,
				},
			},
		})
		vim.cmd("colorscheme catppuccin")
	end,
}

return { M }
