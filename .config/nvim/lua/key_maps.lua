-- Key maps
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("v", "<C-x>", '"+d', { desc = "Cut to system clipboard" })
vim.keymap.set("v", "<C-Down>", "y'>pgv", { desc = "Duplicate selection below and keep selection active" })
vim.keymap.set("v", "<C-Up>", "y'<Pgv", { desc = "Duplicate selection above and keep selection active" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selected lines" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Un-indent selected lines" })
vim.keymap.set("n", "<C-A>", "ggVG", {})
vim.keymap.set({"n", "v", "x"}, "<BS>", "dd", {})

