local on_attach = require("lib.on_attach")

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

local default_config = {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach,
}

local lspconfig = require("lspconfig")
lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, default_config)

require("lspconfig").lua_ls.setup({
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							-- "${3rd}/luv/library"
							-- "${3rd}/busted/library",
						},
						-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
						-- library = vim.api.nvim_get_runtime_file("", true)
					},
				},
			})

			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end
		return true
	end,
})

require("lspconfig").jsonls.setup({
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

require("lspconfig").graphql.setup({
	filetypes = { "graphql", "typescript", "typescriptreact", "javascript", "javascriptreact" },
})

require("lspconfig").tsserver.setup({})

--Enable (broadcasting) snippet capability for completion
local cssls_capabilities = vim.lsp.protocol.make_client_capabilities()
cssls_capabilities.textDocument.completion.completionItem.snippetSupport = true
require("lspconfig").cssls.setup({
	capabilities = cssls_capabilities,
})

require("lspconfig").html.setup({})
require("lspconfig").astro.setup({})
require("lspconfig").svelte.setup({})
