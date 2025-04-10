local M = {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup({
            -- Optional: Treesitter integration
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            mappings = {
                basic = true,
                extra = true,
                extended = true,
            },
        })
        vim.keymap.set("n", "<C-_>", "gcc", { remap = true })
        vim.keymap.set("x", "<C-_>", "gc", { remap = true })
    end,
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring", -- optional for JSX, HTML
    },
}

return { M }
