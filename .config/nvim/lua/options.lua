-- Menu auto-complete
vim.opt.completeopt = "menu,menuone,noselect"

-- Apply settings and fixes quickly
vim.opt.updatetime = 50

-- Mouse settings
vim.opt.mouse = "a"

-- Indents
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.list = true
vim.opt.smartindent = true

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- undo, swap, backup, buffer
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = ".undodir"
vim.opt.undofile = true
vim.opt.hidden = true -- Switch buffers without saving

-- GUI
vim.opt.termguicolors = true
vim.opt.guifont = "MesloLGC Nerd Fotn Mono:h18"
vim.opt.nu = true
vim.opt.cmdheight = 1
vim.opt.sidescroll = 1
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.colorcolumn = "80,120"
vim.opt.showtabline = 2
vim.opt.equalalways = false
vim.opt.wrap = false
vim.opt.textwidth = 79

-- English Language
vim.opt.autoread = true
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- Programming language
vim.opt.complete:append("k")
vim.opt.encoding = "utf-8"

-- Python
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.py",
    callback = function()
        vim.opt.textwidth = 79
        vim.opt.colorcolumn = "79"
    end,
}) -- python formatting

-- Files Options
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.cmd('normal! g`"')
        end
    end,
}) -- return to last edit position when opening files

local CleanOnSave = vim.api.nvim_create_augroup("CleanOnSave", {})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = CleanOnSave,
    pattern = "*",
    command = [[%s/\s\+$//e]],
}) -- remove trailing whitespace from all lines before saving a file)
