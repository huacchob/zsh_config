
-- local leader
vim.g.maplocalleader = ","

-- clipboard
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("v", "<C-x>", '"+d', { desc = "Cut to system clipboard" })

-- Dup line up or down
vim.keymap.set("n", "<C-Down>", "yyp", { desc = "Duplicate line below" })
vim.keymap.set("n", "<C-Up>", "yyP", { desc = "Duplicate line below" })

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

-- Make arrow keys behave like h/j/k/l in Normal and Visual modes
vim.keymap.set({ "x", "n" }, "<Down>", "j", { noremap = true })
vim.keymap.set({ "x", "n" }, "<Up>", "k", { noremap = true })
vim.keymap.set({ "x", "n" }, "<Left>", "h", { noremap = true })
vim.keymap.set({ "x", "n" }, "<Right>", "l", { noremap = true })

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

-- Highlight all lines in V-Line mode when moving the cursor
vim.keymap.set("x", "<Down>", function()
	local cur = vim.api.nvim_win_get_cursor(0)
	local new_line = math.min(cur[1] + 1, vim.api.nvim_buf_line_count(0))
	local new_col = math.min(cur[2], #vim.fn.getline(new_line))
	vim.api.nvim_win_set_cursor(0, { new_line, new_col })
end, { desc = "Safe down in visual line mode", silent = true })

-- No highlight search
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>")

-- Undo in insert mode
vim.keymap.set("i", "<C-z>", "<C-o>u", { desc = "Undo in insert mode" })

-- Triple quotes
vim.keymap.set("i", "'''", "'''''<Left><left><left>'", { desc = "Tripple single quotes" })
vim.keymap.set("i", '"""', '""""""<Left><left><left>', { desc = "Tripple double quotes" })

-- remap visual block mode
vim.keymap.set("n", "<A-v>", "<C-v>", { noremap = true })

-- Make arrow keys behave like h/j/k/l in Normal and Visual modes
vim.keymap.set({ "x", "n" }, "<Down>", "j", { noremap = true })
vim.keymap.set({ "x", "n" }, "<Up>", "k", { noremap = true })
vim.keymap.set({ "x", "n" }, "<Left>", "h", { noremap = true })
vim.keymap.set({ "x", "n" }, "<Right>", "l", { noremap = true })

-- tabs
vim.keymap.set("n", "<leader>to", ":tabnew<cr>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tc", ":tabclose<cr>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", ":tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>tp", ":tabprevious<cr>", { desc = "Previous tab" })

