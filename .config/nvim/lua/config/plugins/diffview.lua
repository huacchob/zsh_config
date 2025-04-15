local M = {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewLog" },
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "Git Diff (Diffview)" },
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
        { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "Repo History" },
        { "<leader>gk", "<cmd>DiffviewClose<cr>",         desc = "Close Diffview" },
        { "<leader>gj", "<cmd>DiffviewToggleFiles<cr>",   desc = "Toggle File Panel" },
    },
    config = function()
        require("diffview").setup({
            enhanced_diff_hl = true, -- Better syntax-aware inline highlighting
            use_icons = true,
            view = {
                merge_tool = {
                    layout = "diff3_mixed",
                    disable_diagnostics = true,
                },
            },
            file_panel = {
                win_config = {
                    position = "left",
                    width = 35,
                },
            },
        })

        -- 🎨 Highlighting for diffs (can be tweaked per theme)
        vim.cmd([[
      highlight DiffAdd      guibg=#144212 guifg=NONE
      highlight DiffDelete   guibg=#4b0000 guifg=NONE
      highlight DiffChange   guibg=#1c1c40 guifg=NONE
      highlight DiffText     guibg=#005f87 guifg=white gui=bold
      ]])

        -- 🏷️ Show HEAD vs Working Tree using winbar
        vim.api.nvim_create_autocmd("BufWinEnter", {
            pattern = "diffview://*",
            callback = function()
                local name = vim.api.nvim_buf_get_name(0)
                local label = "Git"

                if name:match("<0:") then
                    label = "Working Tree"
                elseif name:match("index:") then
                    label = "Index"
                elseif name:match(":/") then
                    local sha = name:match(":/([a-f0-9]+)")
                    label = sha and sha:sub(1, 7) or "Commit"
                end

                vim.wo.winbar = "%=%#WinBar# " .. label .. " "
            end,
        })

        -- 🖱️ Enable scrollbind on both sides for synced scroll
        vim.api.nvim_create_autocmd({ "FileType", "WinEnter" }, {
            pattern = "DiffviewFile",
            callback = function()
                vim.opt_local.scrollbind = true
            end,
        })
    end,
}

return M
