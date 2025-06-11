local M = {
    "echasnovski/mini.nvim",
    enabled = true,
    config = function()
      require("mini.statusline").setup({
        use_icons = true,
        set_vim_settings = true,
      })

      require("mini.indentscope").setup({
        symbol = "│",
        options = { try_as_border = true },
      })

      require("mini.pairs").setup()
    end,
}

return { M }
