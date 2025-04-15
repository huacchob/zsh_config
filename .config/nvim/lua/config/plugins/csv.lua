local M = {
    "chrisbra/csv.vim",
    ft = { "csv", "tsv" },
    config = function()
        vim.g.csv_autocmd_arrange = 1 -- auto-align on open
        vim.g.csv_highlight_column = "y" -- enable column highlights
    end,
}

return { M }
