require("tmux").setup({
	copy_sync = {
		-- Clipboard management + syncing is handled by yanky.nvim.
		enable = false,
	},
	resize = {
		enable_default_keybindings = false,
	},
})
