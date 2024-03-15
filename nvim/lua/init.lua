require("config-aerial")
require("config-auto-session")
require("config-autopairs")
require("config-cmp")
require("config-comment")
require("config-diagnostics")
require("config-lsp")
require("config-lualine")
require("config-metals")
require("config-netrw")
require("config-null-ls")
require("config-surround")
require("config-telescope")
require("config-tmux")
require("config-treesitter")
require("config-yanky")

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- UI
vim.opt.termguicolors = true
vim.opt.lazyredraw = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.showmode = false

-- Invisible characters
vim.opt.list = true
vim.opt.listchars = "tab:  ,trail:·,extends:…,precedes:…"

-- Colorscheme
vim.cmd([[colorscheme oh-lucy-evening]])

-- Indention
vim.opt.filetype = "on"
vim.opt.filetype.plugin = "on"
vim.opt.filetype.indent = "on"
vim.opt.tabstop = 8
vim.opt.expandtab = true

-- Disable mouse
vim.opt.mouse = ""

-- Fix UI bug where highlighted line extends past current line
vim.opt.colorcolumn = "99999"

-- Folding
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99

-- Make 0 go to first character in line
vim.keymap.set({ "n", "x" }, "0", "^")

-- Set CursorHover time (in milliseconds). Affects hover diagnostics.
vim.o.updatetime = 100
