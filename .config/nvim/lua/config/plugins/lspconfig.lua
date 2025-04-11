local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			cmp_nvim_lsp.default_capabilities()
		)

		if pcall(require, "ufo") then
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
		end

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup({
			ensure_installed = {
				"tsserver",
				"html",
				"cssls",
				"lua_ls",
				"basedpyright",
				"clangd",
				"robotframework_ls",
				"bashls",
				"marksman",
			},
			automatic_installation = true,
		})

		local python = vim.fn.trim(vim.fn.system("poetry env info -p")) .. "/bin/python"

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({ capabilities = capabilities })
			end,

			["lua_ls"] = function()
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							completion = { callSnippet = "Replace" },
						},
					},
				})
			end,

			["basedpyright"] = function()
				lspconfig["basedpyright"].setup({
					capabilities = capabilities,
					root_dir = lspconfig.util.root_pattern("pyproject.toml", ".git"),
					settings = {
						basedpyright = {
							typeCheckingMode = "strict",
							disableOrganizeImports = true,
							analysis = {
								diagnosticMode = "openFilesOnly",
								autoImportCompletions = true,
							},
							pythonPath = python,
						},
					},
				})
			end,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }
				local keymap = vim.keymap
				local tb = require("telescope.builtin")

				opts.desc = "Go to [D]efinition"
				keymap.set("n", "gd", tb.lsp_definitions, opts)
				opts.desc = "Go to [R]eferences"
				keymap.set("n", "gr", tb.lsp_references, opts)
				opts.desc = "Go to [I]mplementation"
				keymap.set("n", "gi", tb.lsp_implementations, opts)
				opts.desc = "Go to [T]ype Definition"
				keymap.set("n", "gt", tb.lsp_type_definitions, opts)
				opts.desc = "Show [H]over Documentation"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)
				opts.desc = "Show do[K]umentation for what is under cursor"
				keymap.set("n", "gk", vim.lsp.buf.hover, opts)
				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				opts.desc = "Find Symbols for [C]urrent Document"
				keymap.set("n", "<leader>fvc", tb.lsp_document_symbols, opts)
				opts.desc = "Find Symbols for [W]orkspace"
				keymap.set("n", "<leader>fvw", tb.lsp_dynamic_workspace_symbols, opts)
				opts.desc = "Find Diagnostic for [C]urrent Buffer"
				keymap.set("n", "<leader>fdc", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
				opts.desc = "Find [L]ine Diagnostics"
				keymap.set("n", "<leader>fdl", vim.diagnostic.open_float, opts)
				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "<leader>fdp", vim.diagnostic.goto_prev, opts)
				opts.desc = "Go to next diagnostic"
				keymap.set("n", "<leader>fdn", vim.diagnostic.goto_next, opts)
				opts.desc = "Restart L[S]P"
				keymap.set("n", "<leader>cs", ":LspRestart<CR>", opts)
				opts.desc = "Smart [R]ename"
				keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
				opts.desc = "See [A]vailable code actions"
				keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = ev.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = ev.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end
			end,
		})

		vim.api.nvim_create_autocmd({ "CursorHold" }, {
			callback = function()
				vim.diagnostic.open_float(nil, {
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
					border = "rounded",
					source = "always",
					prefix = "",
					scope = "cursor",
				})
			end,
		})
	end,
}

return { M }
