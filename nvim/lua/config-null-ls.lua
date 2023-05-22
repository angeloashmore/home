local null_ls = require("null-ls")
local on_attach = require("lib.on_attach")

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.eslint_d.with({
			diagnostics_format = "[#{c}] #{m}",
			-- ignore prettier warnings from eslint-plugin-prettier
			filter = function(diagnostic)
				return diagnostic.code ~= "prettier/prettier"
			end,
		}),
		null_ls.builtins.formatting.prettier.with({
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"css",
				"scss",
				"less",
				"html",
				"json",
				"jsonc",
				"yaml",
				"markdown",
				"markdown.mdx",
				"graphql",
				"handlebars",
				"astro",
				"svelte",
			},
		}),
		null_ls.builtins.formatting.stylua,
	},
	on_attach = on_attach,
})
