-- lua/config/plugins/vim_fugitive.lua
local M = {
    "tpope/vim-fugitive",
    cmd = {
        "Git",
        "Gedit",
        "Gdiffsplit",
        "Gvdiffsplit",
        "Gwrite",
        "Gread",
        "Glog",
        "GMove",
        "GDelete",
        "GBrowse",
        "Gtabedit",
    },
    keys = {
        { "<leader>gs", "<cmd>Git<cr>",        desc = "Git Status (Fugitive)" },
        { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
        { "<leader>gp", "<cmd>Git push<cr>",   desc = "Git Push" },
        { "<leader>gl", "<cmd>Git log<cr>",    desc = "Git Log" },
    },
    config = function()
        vim.cmd([[
      augroup FugitiveEnhancements
      autocmd!
      autocmd FileType fugitive setlocal bufhidden=delete nobuflisted nowrap cursorline
      autocmd FileType gitcommit setlocal spell textwidth=72 conceallevel=2
      autocmd FileType fugitiveblame setlocal number cursorline
      augroup END
      ]])
    end,
}

return { M }
