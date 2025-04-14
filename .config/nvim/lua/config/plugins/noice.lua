local M = {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        require("noice").setup({
            cmdline = {
                enabled = true,
                -- view = "cmdline_popup", -- VSCode-style floating input
                view = "cmdline",
                format = {
                    cmdline = { icon = "", title = "", lang = "vim" },
                    search_down = { icon = " ", lang = "regex" },
                    search_up = { icon = " ", lang = "regex" },
                },
            },
            messages = {
                enabled = true,
                view = "mini", -- or "notify" or "split"
                view_error = "notify", -- show errors as nvim-notify
                view_warn = "notify", -- show warnings as nvim-notify
                view_history = "messages",
                view_search = "virtualtext",
            },
            popupmenu = {
                enabled = true,
                backend = "nui", -- replaces native wildmenu
            },
            lsp = {
                progress = {
                    enabled = true,
                    format = " %l %p%%",
                    throttle = 1000 / 30,
                },
                signature = {
                    enabled = true,
                    auto_open = {
                        enabled = true,
                        trigger = true,
                        luasnip = true,
                    },
                },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            -- views = {
            --     cmdline_popup = {
            --         keys = {
            --             ["<Up>"] = "previous",
            --             ["<Down>"] = "next",
            --         },
            --         position = {
            --             row = "90%",
            --             col = "50%",
            --         },
            --         size = {
            --             width = 60,
            --             height = "auto",
            --         },
            --         border = {
            --             style = "rounded",
            --             padding = { 0, 1 },
            --         },
            --         win_options = {
            --             winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            --         },
            --     },
            -- },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = "written",
                    },
                    opts = { skip = true }, -- suppress "x lines written" message
                },
            },
            presets = {
                bottom_search = true,
                command_palette = false,
                -- command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
        })
    end,
}

return { M }
