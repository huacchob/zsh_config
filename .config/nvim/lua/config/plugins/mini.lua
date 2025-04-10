local M = {
    "echasnovski/mini.nvim",
    enabled = true,
    config = function()
        local statusline = require("mini.statusline")
        statusline.setup({
            use_icons = true,
            set_vim_settings = true,
        })
        require("mini.indentscope").setup({
            symbol = "│",
            options = { try_as_border = true },
        })
        -- require("mini.animate").setup()
        require("mini.pairs").setup()
        require("mini.clue").setup({
            triggers = {
                -- Leader key
                { mode = "n", keys = "<Leader>" },
                { mode = "x", keys = "<Leader>" },

                -- Built-in things like `g`, `z`, etc.
                { mode = "n", keys = "g" },
                { mode = "n", keys = "z" },
                { mode = "n", keys = "[" },
                { mode = "n", keys = "]" },
            },

            clues = {
                -- Custom descriptions
                { mode = "n", keys = "<Leader>f", desc = "Find" },
                { mode = "n", keys = "<Leader>c", desc = "Code actions" },
                { mode = "n", keys = "<Leader>b", desc = "Buffers" },
                { mode = "n", keys = "<Leader>w", desc = "Save file" },
            },

            window = {
                config = {
                    width = "auto",
                    height = 20,
                    border = "rounded",
                    row = "auto",
                    col = "auto",
                },
            },
        })
        local mode_hl = {
            NORMAL = "MiniStatuslineModeNormal",
            INSERT = "MiniStatuslineModeInsert",
            VISUAL = "MiniStatuslineModeVisual",
            REPLACE = "MiniStatuslineModeReplace",
            COMMAND = "MiniStatuslineModeCommand",
            OTHER = "MiniStatuslineModeOther",
        }

        statusline.section_location = function()
            return "%2l:%-2v"
        end

        statusline.section_git = function()
            local branch = vim.b.gitsigns_head or ""
            return branch ~= "" and " " .. branch or ""
        end

        statusline.section_diagnostics = function()
            local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
            local warns = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
            if errors + warns == 0 then
                return ""
            end
            return string.format(" %s  %s", errors, warns)
        end

        statusline.section_active = function()
            return {
                statusline.section_mode({ hl = mode_hl }),
                statusline.section_git(),
                "%f",
                "%=",
                statusline.section_diagnostics(),
                statusline.section_location(),
            }
        end

        statusline.section_inactive = function()
            return {
                "%f",
                "%=",
                statusline.section_location(),
            }
        end
    end,
}

return { M }
