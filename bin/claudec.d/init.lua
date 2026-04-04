vim.g.clipboard = "osc52"
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.mouse = ""
vim.keymap.set({ "n", "x" }, "0", "^")

vim.pack.add({
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/alexghergh/nvim-tmux-navigation",
})
require("nvim-surround").setup()
require("nvim-tmux-navigation").setup({
  keybindings = {
    left = "<C-h>",
    down = "<C-j>",
    up = "<C-k>",
    right = "<C-l>",
    last_active = "<C-\\>",
    next = "<C-Space>",
  },
})
