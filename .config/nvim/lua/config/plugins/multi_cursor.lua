local M = {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      require("multicursor-nvim").setup()
    end,
}

return { M }
