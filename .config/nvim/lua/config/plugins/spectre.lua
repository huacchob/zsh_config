local M = {
    "nvim-pack/nvim-spectre",
    keys = {
      {
        "<C-f>",
        function()
          require("spectre").open_file_search({ select_word = true })
        end,
        desc = "Spectre: Search in current file",
      },
    },
    config = function()
      require("spectre").setup()
    end,
}

return { M }
