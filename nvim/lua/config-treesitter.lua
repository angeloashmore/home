require("nvim-treesitter.configs").setup({
	parser_install_dir = "~/.config/treesitter/parsers",
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})

vim.opt.runtimepath:append("~/.config/treesitter/parsers")
