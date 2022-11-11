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
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
	},
	on_attach = on_attach,
})
