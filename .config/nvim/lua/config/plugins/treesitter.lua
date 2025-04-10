local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        vim.g.mapleader = " "
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = {
                "python",
                "go",
                "lua",
                "vim",
                "javascript",
                "html",
                "jinja",
                "bash",
                "regex",
            },
            auto_install = true,
            sync_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            fold = { enable = true },
            indent = { enable = true },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymap = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
            },
        })
        vim.keymap.set(
            "n",
            "<leader>n",
            ":Neotree filesystem reveal left<CR>",
            { desc = "Show filesystem on the left" }
        )
        -- vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        --     pattern = "*",
        --     callback = function()
        --         vim.opt.foldmethod = "expr"
        --         vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        --         vim.opt.foldenable = true
        --         vim.opt.foldlevel = 99
        --         vim.cmd("silent! normal! zx")
        --     end,
        -- })
    end,
}

return { M }
