local M = { -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            build = (function()
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),
        },
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline", -- 🔥 Enables : and / completion
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        require("luasnip.loaders.from_vscode").lazy_load()
        luasnip.config.setup({})

        local kind_icons = {
            Text = "󰉿",
            Method = "m",
            Function = "󰊕",
            Constructor = "",
            Field = "",
            Variable = "󰆧",
            Class = "󰌗",
            Interface = "",
            Module = "",
            Property = "",
            Unit = "",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰇽",
            Struct = "",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰊄",
        }

        -- Insert mode completion
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-c>"] = cmp.mapping.complete({}),
                ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { "i", "s" }),
                ["<C-h>"] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { "i", "s" }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snippet]",
                        buffer = "[Buffer]",
                        path = "[Path]",
                    })[entry.source.name]
                    return vim_item
                end,
            },
        })

        -- Command-line mode completion (":")
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline({
                ["<Tab>"] = {
                    c = function()
                        cmp.select_next_item()
                    end,
                },
                ["<S-Tab>"] = {
                    c = function()
                        cmp.select_prev_item()
                    end,
                },
                ["<Up>"] = {
                    c = function()
                        cmp.select_prev_item()
                    end,
                },
                ["<Down>"] = {
                    c = function()
                        cmp.select_next_item()
                    end,
                },
                ["<CR>"] = {
                    c = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    }),
                },
            }),
            sources = cmp.config.sources({
                { name = "path" },
                { name = "cmdline" },
            }),
            sorting = {
                comparators = {
                    cmp.config.compare.sort_text, -- sort by textual similarity
                    cmp.config.compare.score,
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
        })

        -- Search mode completion ("/")
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline({
                ["<Tab>"] = {
                    c = function()
                        cmp.select_next_item()
                    end,
                },
                ["<S-Tab>"] = {
                    c = function()
                        cmp.select_prev_item()
                    end,
                },
                ["<Up>"] = {
                    c = function()
                        cmp.select_prev_item()
                    end,
                },
                ["<Down>"] = {
                    c = function()
                        cmp.select_next_item()
                    end,
                },
                ["<CR>"] = {
                    c = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    }),
                },
            }),
            sources = {
                { name = "buffer" },
            },
        })
    end,
}

return { M }
