require("lsp_signature").setup({
	hint_enable = false,
	handler_opts = {
		border = "none",
	},
	padding = " ",
	floating_window_off_x = 0,
	floating_window_off_y = 0,
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- List of LSPs whose built-in formatters will *not* be used. Third-party formatters will be used via null-ls instead.
local lsp_with_third_party_formatter = {
	"sumneko_lua",
	"tsserver",
	"jsonls",
	"cssls",
	"html",
}

local default_config = {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = function(client, bufnr)
		-- Disable LSP-powered formatting if a third-party formatter will be used via null-ls.
		for _, server in pairs(lsp_with_third_party_formatter) do
			if client.name == server then
				client.server_capabilities.documentFormattingProvider = false
			end
		end

		-- Format on save.
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("Format", { clear = true }),
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end

		-- Show diagnostics on hover.
		vim.api.nvim_create_autocmd("CursorHold", {
			buffer = bufnr,
			callback = function()
				vim.diagnostic.open_float(nil, {
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
					source = "always",
					scope = "cursor",
					header = "",
				})
			end,
		})

		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		-- Custom hover (i.e. "K") function needed to ensure hover popup appears above CursorHold diagnostics.
		-- This should be treated as a hack.
		function HoverPatched()
			vim.api.nvim_command("set eventignore=CursorHold")
			vim.lsp.buf.hover()
			vim.api.nvim_command('autocmd CursorMoved <buffer> ++once set eventignore=""')
		end

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("n", "K", HoverPatched, bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
		vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, bufopts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	end,
}

local lspconfig = require("lspconfig")
lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, default_config)

require("lspconfig").sumneko_lua.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

require("lspconfig").jsonls.setup({
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

require("lspconfig").tsserver.setup({})
require("lspconfig").cssls.setup({})
require("lspconfig").html.setup({})
