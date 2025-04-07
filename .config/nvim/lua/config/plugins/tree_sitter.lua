local M = {
     "nvim-treesitter/nvim-treesitter",
     build = ":TSUpdate",
     config = function () 
        local configs = require("nvim-treesitter.configs")

        configs.setup(
            {
                ensure_installed = { "python", "go", "lua", "vim", "javascript", "html", "jinja" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },  
            }
        )
        vim.keymap.set(
            "n", "<leader>n", ":Neotree filesystem reveal left<CR>", { desc = "Show filesystem on the left" }
        )
    end
}

return { M }
