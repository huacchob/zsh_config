-- clipboard
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("v", "<C-x>", '"+d', { desc = "Cut to system clipboard" })

-- Dup line up or down
vim.keymap.set("v", "<C-Down>", "y'>pgv", { desc = "Duplicate selection below and keep selection active" })
vim.keymap.set("v", "<C-Up>", "y'<Pgv", { desc = "Duplicate selection above and keep selection active" })

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
    local view = vim.fn.winsaveview()       -- Save window view (scroll offset)
    vim.cmd("silent! write")                -- Write the file
    vim.fn.winrestview(view)                -- Restore scroll/view
    vim.api.nvim_win_set_cursor(0, pos)     -- Restore cursor position
end, { desc = "Save file without jumping to top" })
vim.keymap.set("n", "<leader>q", ":q<cr>")
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
