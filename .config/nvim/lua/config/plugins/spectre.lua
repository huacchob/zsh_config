local M = {
    "nvim-pack/nvim-spectre",
    build = false,
    keys = {
        {
            "<C-f>",
            function()
                require("spectre").open_file_search({
                    select_word = true,
                    is_insert_mode = true,
                    path = vim.api.nvim_buf_get_name(0),
                })
            end,
            desc = "Spectre: Search in current file",
        },
    },
    config = function()
        require("spectre").setup({
            cmd = function()
                local spectre = require("spectre")
                local entry = spectre.state.current_entry
                if not entry then
                    return
                end

                spectre.actions.select_entry()

                -- Manual highlight
                local lnum = entry.lnum or 1
                local col = entry.col or 1
                local match_len = entry.match and #entry.match or 1

                local buf = vim.api.nvim_get_current_buf()
                local ns = vim.api.nvim_create_namespace("SpectrePreviewHighlight")

                vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
                vim.highlight.range(
                    buf,
                    ns,
                    "IncSearch",
                    { lnum - 1, col - 1 },
                    { lnum - 1, col - 1 + match_len },
                    { priority = 100 }
                )

                -- Return focus to Spectre
                vim.cmd("wincmd h")
            end,
            open_cmd = "noswapfile vnew", -- opens Spectre in a vertical split without swapfile
            live_update = true,  -- real-time search updates
            is_insert_mode = false,
            line_sep_start = "╭──────────────────────────────────────────",
            result_padding = "│ ",
            line_sep = "╰──────────────────────────────────────────",
            highlight = {
                ui = "String",
                search = "DiffChange",
                replace = "DiffDelete",
            },
            mapping = {
                ["toggle_line"] = {
                    map = "dd",
                    cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
                    desc = "toggle current item",
                },
                ["enter_file"] = {
                    map = "<CR>",
                    cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
                    desc = "go to file",
                },
                ["send_to_qf"] = {
                    map = "<leader>q",
                    cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
                    desc = "send to quickfix",
                },
                ["replace_cmd"] = {
                    map = "<leader>r",
                    cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
                    desc = "replace command",
                },
                ["run_replace"] = {
                    map = "<leader>R",
                    cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
                    desc = "replace all",
                },
                ["change_view_mode"] = {
                    map = "<C-h>",
                    cmd = "<cmd>lua require('spectre').change_view()<CR>",
                    desc = "toggle view mode",
                },
            },
        })
    end,
}

return { M }
