local M = {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local sorters = require("telescope.sorters")
        require("telescope").setup({
            defaults = {
                prompt_prefix = "🔍 ",
                selection_caret = "➤ ",
                path_display = { "truncate" },

                mappings = {
                    i = {
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                        ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
                        ["<Esc>"] = require("telescope.actions").close,
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                oldfiles = {
                    initial_mode = "normal",
                    sorter = sorters.fuzzy_with_index_bias(),
                },
                command_history = { sorter = sorters.fuzzy_with_index_bias() },
                git_files = { show_untracked = true, wrap_results = true },
                live_grep = {
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                },
            },
        })

        require("telescope").load_extension("fzf")

        vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
        vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
        vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find Buffers" })
        vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find Help Tags" })
        vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "LSP Symbols" })
        vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP References" })

        require("telescope").setup({
            defaults = {
                layout_config = {
                    preview_width = 0.55,
                    prompt_position = "top",
                },
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                winblend = 0,
            },
        })
        vim.keymap.set("n", "<leader>fh", function()
            require("telescope.builtin").help_tags()
        end, { desc = "Help Tags (Docs)" })
        vim.cmd([[
            autocmd User TelescopePreviewerLoaded setlocal wrap
            ]])
    end,
}

return { M }
