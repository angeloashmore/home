local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.eslint_d.with({
			diagnostics_format = "[#{c}] #{m}",
			-- ignore prettier warnings from eslint-plugin-prettier
			filter = function(diagnostic)
				return diagnostic.code ~= "prettier/prettier"
			end,
		}),
		null_ls.builtins.formatting.prettier_d_slim,
		null_ls.builtins.formatting.stylua,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
