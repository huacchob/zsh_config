local M = {
    "danymat/neogen",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "L3MON4D3/LuaSnip", -- make sure luasnip is installed if you're using it
    },
    config = function()
        require("neogen").setup({
            enabled = true,
            snippet_engine = "luasnip", -- can be "vsnip", "snippy", etc. if you're using something else
            languages = {
                python = {
                    template = {
                        annotation_convention = "google_docstrings", -- valid options: "google", "numpydoc", "reST"
                    },
                },
            },
        })
    end,
    keys = {
        {
            "<leader>ds",
            function()
                require("neogen").generate()
            end,
            desc = "Generate Python docstring",
        },
    },
    cmd = { "Neogen" }, -- optional, speeds up startup
}

return { M }
