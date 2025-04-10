local M = {
	"rcarriga/nvim-notify",
	lazy = false,
	priority = 1000,
	config = function()
		local notify = require("notify")
		notify.setup({
			render = "default",
			stages = "slide",
			timeout = 4000,
			level = vim.log.levels.INFO,
			background_colour = "#1e1e2e",
			max_width = math.floor(vim.o.columns * 0.4),
			max_height = math.floor(vim.o.lines * 0.4),
			fps = 60,
			top_down = true,
			icons = {
				ERROR = "",
				WARN = "",
				INFO = "",
				DEBUG = "",
				TRACE = "✎",
			},
		})
		vim.notify = notify
	end,
}

return { M }
