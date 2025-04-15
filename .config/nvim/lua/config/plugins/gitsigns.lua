-- lua/config/plugins/gitsigns.lua
local M = {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            signcolumn = true,
            numhl = false,
            linehl = false,
            word_diff = false,
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 300,
                ignore_whitespace = true,
            },
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                end

                map("n", "]c", gs.next_hunk, "Next Hunk")
                map("n", "[c", gs.prev_hunk, "Prev Hunk")
                map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
                map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
                map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<leader>hb", gs.blame_line, "Blame Line")
                map("n", "<leader>hd", gs.diffthis, "Diff This")
                map("n", "<leader>hD", function()
                    gs.diffthis("~")
                end, "Diff HEAD")
            end,
        })
    end,
}

return { M }
