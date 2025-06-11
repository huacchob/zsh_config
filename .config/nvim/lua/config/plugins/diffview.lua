local M = {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewLog" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git Diff (Diffview)" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Repo History" },
      { "<leader>gk", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
      { "<leader>gj", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle File Panel" },
    },
    config = function()
      require("diffview").setup()
    end,
}

return M
