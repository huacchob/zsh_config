local M = {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    lazy = false,
    opts = {
        close_if_last_window = true,
        enable_git_status = true,
        enable_diagnostics = true,
        popup_border_style = "rounded",
        default_component_configs = {
            indent = { padding = 1 },
        },
        name = {
            trailing_slash = false,
            use_git_status_colors = true,
        },
    },
    window = {
        position = "left",
        width = 35,
        mappings = {
            ["<F2>"] = "rename",     -- Custom: use F2 to rename like VSCode
            ["R"] = "rename",        -- Default rename key (keep it too)
            ["z"] = "none",          -- unbind 'z' if unused
            ["?"] = "show_help",
            ["<space>"] = "toggle_node",
            ["<cr>"] = "open",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["q"] = "close_window",
            ["A"] = "add",
            ["D"] = "delete",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["v"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = "move",
            ["H"] = "toggle_hidden",
        },
    },
    filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = {
            visible = true,
            force_visible_in_empty_folder = true,
            show_hidden_count = true,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {},
            never_show = {},
        },
    },
    buffers = {
        follow_current_file = { enabled = true },
        group_empty_dirs = true,
        show_unloaded = true,
    },
    git_status = {
        window = {
            position = "float",
        },
    },
}

return { M }
