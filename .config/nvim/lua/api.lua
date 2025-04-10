vim.api.nvim_create_autocmd("FileType", {
    pattern = "*", -- or limit to { "lua", "python", "javascript" }
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.expandtab = true
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.cmd("retab")         -- converts existing indents to match 'tabstop', 'expandtab'
        vim.cmd("normal! gg=G")  -- optional: reindent after retab
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.keymap.set("n", "K", function()
            local word = vim.fn.expand("<cword>")
            local pydoc_cmd = string.format("python3 -c 'import pydoc; print(pydoc.render_doc(\"%s\", renderer=pydoc.plaintext))' 2>/dev/null", word)
            local output = vim.fn.systemlist(pydoc_cmd)
            if output and #output > 1 and not output[1]:match("^No Python documentation found") then
                vim.lsp.util.open_floating_preview(output, "help", { border = "rounded" })
                return
            end
            vim.lsp.buf.hover()
        end, { buffer = true, desc = "Python help (pydoc or LSP)" })
    end,
})
