-- clipboard
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("v", "<C-x>", '"+d', { desc = "Cut to system clipboard" })

-- Dup line up or down
vim.keymap.set("v", "<C-Down>", function()
	local buf = vim.api.nvim_get_current_buf()

	-- Get range of visual selection (0-indexed)
	local start_line = vim.fn.line("v") - 1
	local end_line = vim.fn.line(".")
	if end_line < start_line then
		start_line, end_line = end_line - 1, start_line
	else
		end_line = end_line - 1
	end

	-- Extract lines
	local lines = vim.api.nvim_buf_get_lines(buf, start_line, end_line + 1, false)

	-- Paste below
	vim.api.nvim_buf_set_lines(buf, end_line + 1, end_line + 1, false, lines)

	-- Reselect new block
	local new_start = end_line + 1
	local new_end = end_line + #lines

	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
	vim.api.nvim_win_set_cursor(0, { new_start + 1, 0 }) -- move to start of new block
	vim.cmd("normal! V")
	vim.api.nvim_win_set_cursor(0, { new_end + 1, 0 }) -- extend selection
	vim.cmd("normal! V")
end, { desc = "Duplicate selected lines down", silent = true })

vim.keymap.set("v", "<C-Up>", function()
	local buf = vim.api.nvim_get_current_buf()

	-- Get visual range (0-indexed)
	local start_line = vim.fn.line("v") - 1
	local end_line = vim.fn.line(".")
	if end_line < start_line then
		start_line, end_line = end_line - 1, start_line
	else
		end_line = end_line - 1
	end

	-- Extract lines
	local lines = vim.api.nvim_buf_get_lines(buf, start_line, end_line + 1, false)

	-- Paste above (insert before start_line)
	vim.api.nvim_buf_set_lines(buf, start_line, start_line, false, lines)

	-- Reselect the newly inserted block
	local new_start = start_line
	local new_end = start_line + #lines - 1

	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
	vim.api.nvim_win_set_cursor(0, { new_start + 1, 0 }) -- move to start of new block
	vim.cmd("normal! V")
	vim.api.nvim_win_set_cursor(0, { new_end + 1, 0 }) -- extend selection
	vim.cmd("normal! V")
end, { desc = "Duplicate selected lines upward", silent = true })

-- Indent multiple lines
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selected lines" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Un-indent selected lines" })

-- Select multiple lines
vim.keymap.set("n", "<C-A>", "ggVG", { desc = "highlight all lines" })

-- Delete lines
vim.keymap.set("n", "<BS>", "dd", { noremap = true, desc = "Removes lines" })
vim.keymap.set({ "v", "x" }, "<BS>", "d", { noremap = true, desc = "remome lines" })

-- Move between split tabs
vim.keymap.set("n", "<M-Left>", "<C-w>h", { noremap = true, silent = true, desc = "left split tab" })
vim.keymap.set("n", "<M-Down>", "<C-w>j", { noremap = true, silent = true, desc = "down split tab" })
vim.keymap.set("n", "<M-Up>", "<C-w>k", { noremap = true, silent = true, desc = "up split tab" })
vim.keymap.set("n", "<M-Right>", "<C-w>l", { noremap = true, silent = true, desc = "right split tab" })

-- buffer
vim.keymap.set("n", "<leader>fn", ":bn<cr>", { desc = "Move forward to the touching buffer" })
vim.keymap.set("n", "<leader>fp", ":bp<cr>", { desc = "Move backward to the touching file" })
vim.keymap.set("n", "<leader>fx", ":bd<cr>", { desc = "Close the current file" })
vim.keymap.set("n", "<leader>fl", ":b#<cr>", { desc = "Move to the last opened file" })

-- save and/or quit file
vim.keymap.set("n", "<leader>w", function()
	local pos = vim.api.nvim_win_get_cursor(0) -- Save cursor position
	local view = vim.fn.winsaveview() -- Save window view (scroll offset)
	vim.cmd("silent! write") -- Write the file
	vim.fn.winrestview(view) -- Restore scroll/view
	vim.api.nvim_win_set_cursor(0, pos) -- Restore cursor position
end, { desc = "Save file without jumping to top" })
vim.keymap.set("n", "<leader>q", ":q!<cr>")
vim.keymap.set("n", "<leader>wq", ":wq<cr>")

-- Horizontal moving in terminal
vim.keymap.set("n", "<C-Right>", "zL", { desc = "Scroll window 5 columns right" })
vim.keymap.set("n", "<C-Left>", "zH", { desc = "Scroll window 5 columns left" })

vim.keymap.set("n", "<Right>", function()
	local col = vim.fn.col(".")
	local line = vim.fn.getline(".")
	local first_non_ws = line:find("%S") or 1
	if col <= first_non_ws then
		return string.format("0%dl", first_non_ws - 1)
	else
		return "l"
	end
end, {
	expr = true,
	noremap = true,
	silent = true,
	desc = "Smart →: Skip indent whitespace to first character",
})
