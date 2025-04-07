-- Load Telescope and its setup
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
