local o = vim.opt
o.termguicolors = true
o.lazyredraw = true
o.cursorline = true
o.number = true
o.showmode = false
o.winborder = "single"
o.laststatus = 0
o.list = true
o.listchars = "tab:  ,trail:·,extends:…,precedes:…"
o.clipboard = "unnamedplus"
o.tabstop = 8
o.expandtab = true
o.ignorecase = true
o.mouse = ""
o.foldmethod = "indent"
o.foldlevelstart = 99
local map = vim.keymap.set
map({ "n", "x" }, "0", "^")
map("t", "<C-w>h", [[<C-\><C-n><C-w>h]])
map("t", "<C-w>j", [[<C-\><C-n><C-w>j]])
map("t", "<C-w>k", [[<C-\><C-n><C-w>k]])
map("t", "<C-w>l", [[<C-\><C-n><C-w>l]])
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "┃",
			[vim.diagnostic.severity.WARN] = "┃",
			[vim.diagnostic.severity.HINT] = "┃",
			[vim.diagnostic.severity.INFO] = "┃",
		},
	},
})
vim.api.nvim_create_autocmd("CursorMoved", {
	callback = function()
		if vim.fn.mode() == "n" then
			vim.diagnostic.open_float(nil, { focusable = false, width = 80 })
		end
	end,
})

local augroup = vim.api.nvim_create_augroup("angeloashmore.cfg", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

local function setup_lsp()
	vim.lsp.enable({
		"astro",
		"cssls",
		"gopls",
		"jsonls",
		"lua_ls",
		"marksman",
		"oxlint",
		"stylelint_lsp",
		"svelte",
		"tailwindcss",
		"ts_ls",
		"vuels",
	})
	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	})
	vim.lsp.config("marksman", {
		filetypes = { "markdown", "markdown.mdx", "mdx" },
	})

	autocmd("LspAttach", {
		group = augroup,
		callback = function()
			map("n", "gd", vim.lsp.buf.definition)
			map("n", "gr", vim.lsp.buf.references)
			map("n", "<leader>rn", vim.lsp.buf.rename)

			vim.o.completeopt = "menuone,noselect,fuzzy"
			vim.opt.iskeyword:append("-")
		end,
	})
end

local function setup_mini_pick()
	local MiniPick = require("mini.pick")
	MiniPick.setup({
		mappings = {
			move_down = "<C-j>",
			move_up = "<C-k>",
		},
	})
	map("n", "<leader>ff", function()
		MiniPick.builtin.files({ tool = "git" })
	end)
	map("n", "<leader>fg", function()
		MiniPick.builtin.grep_live()
	end)
	map("n", "<leader>fb", function()
		MiniPick.builtin.buffers()
	end)
	local MiniExtra = require("mini.extra")
	map("n", "<leader>fh", function()
		MiniExtra.pickers.oldfiles()
	end)
	map("n", "<leader>fs", function()
		MiniExtra.pickers.lsp({ scope = "workspace_symbol" })
	end)
	map("n", "<leader>fa", function()
		MiniExtra.pickers.lsp({ scope = "document_symbol" })
	end)
end

local function setup_treesitter()
	local ts_parsers = {
		"astro",
		"bash",
		"dockerfile",
		"git_config",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"go",
		"gomod",
		"gosum",
		"html",
		"javascript",
		"json",
		"lua",
		"markdown",
		"sql",
		"svelte",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vue",
		"yaml",
	}
	local nts = require("nvim-treesitter")
	nts.install(ts_parsers)
	autocmd("PackChanged", { -- update treesitter parsers/queries with plugin updates
		group = augroup,
		callback = function(ev)
			local spec = ev.data.spec
			if spec and spec.name == "nvim-treesitter" and ev.data.kind == "update" then
				vim.schedule(function()
					nts.update()
				end)
			end
		end,
	})
	autocmd("FileType", { -- enable treesitter highlighting and indents
		group = augroup,
		callback = function(ev)
			local filetype = ev.match
			local lang = vim.treesitter.language.get_lang(filetype)
			if vim.treesitter.language.add(lang) then
				if vim.treesitter.query.get(filetype, "indents") then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
				if vim.treesitter.query.get(filetype, "folds") then
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				end
				vim.treesitter.start()
			end
		end,
	})
end

-- local function setup_lint()
-- 	local function get_linters()
-- 		if vim.fn.executable("oxlint") == 1 then
-- 			return { "oxlint" }
-- 		end
-- 		return { "eslint" }
-- 	end
--
-- 	local lint = require("lint")
--
-- 	lint.linters_by_ft = {
-- 		javascript = get_linters(),
-- 		typescript = get_linters(),
-- 		javascriptreact = get_linters(),
-- 		typescriptreact = get_linters(),
-- 	}
--
-- 	vim.api.nvim_create_autocmd({
-- 		"BufEnter",
-- 		"BufReadPost",
-- 		"BufWritePost",
-- 		"InsertLeave",
-- 		"TextChanged",
-- 	}, {
-- 		group = vim.api.nvim_create_augroup("Linting", { clear = true }),
-- 		callback = function()
-- 			lint.try_lint()
-- 		end,
-- 	})
-- end

local function setup_oil()
	local oil = require("oil")
	oil.setup({
		columns = {},
		delete_to_trash = true,
		view_options = {
			show_hidden = true,
			is_always_hidden = function(name)
				return name == ".." or name == ".DS_Store"
			end,
		},
		keymaps = {
			["<C-r>"] = "actions.refresh",
			["<C-h>"] = false,
			["<C-l>"] = false,
			["~"] = {
				callback = function()
					oil.open(vim.fn.expand("~"))
				end,
				mode = "n",
			},
		},
	})
	map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end

local function setup_indent_blankline()
	local hooks = require("ibl.hooks")
	hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2e2a31" })
	end)

	require("ibl").setup({
		indent = {
			char = "▏",
			tab_char = "▏",
			smart_indent_cap = true,
		},
		scope = {
			enabled = false,
		},
	})
end

local function setup_mini_completion()
	require("mini.completion").setup({
		fallback_action = function() end,
	})
	local function cr_action()
		if vim.fn.pumvisible() ~= 0 then
			local item_selected = vim.fn.complete_info()["selected"] ~= -1
			return item_selected and vim.keycode("<C-y>") or vim.keycode("<C-y><CR>")
		end

		return require("mini.pairs").cr()
	end
	local function has_words_before()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end
	local function show_completions()
		if vim.fn.pumvisible() == 1 then
			return "<C-n>"
		elseif has_words_before() then
			require("mini.completion").complete_twostage()
		else
			return "<Tab>"
		end
	end
	map("i", "<CR>", cr_action, { expr = true })
	map("i", "<Tab>", show_completions, { expr = true })
	map("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
end

vim.pack.add({
	"https://github.com/alexghergh/nvim-tmux-navigation",
	"https://github.com/b0o/schemastore.nvim",
	"https://github.com/davidmh/mdx.nvim",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	-- "https://github.com/mfussenegger/nvim-lint",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-mini/mini.completion",
	"https://github.com/nvim-mini/mini.extra",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-mini/mini.indentscope",
	"https://github.com/nvim-mini/mini.pairs",
	"https://github.com/nvim-mini/mini.pick",
	"https://github.com/nvim-mini/mini.sessions",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/tpope/vim-abolish",
	"https://github.com/tpope/vim-dispatch",
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/tpope/vim-rhubarb",
	"https://github.com/yazeed1s/oh-lucy.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

vim.cmd.colorscheme("oh-lucy-evening")
setup_treesitter()
setup_lsp()
-- setup_lint()
setup_oil()
setup_indent_blankline()
setup_mini_completion()
setup_mini_pick()
require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.extra").setup()
require("mini.sessions").setup({
	autoread = true,
	autowrite = true,
})
require("mini.indentscope").setup({
	draw = {
		delay = 0,
		animation = function()
			return 0
		end,
	},
	symbol = "▏",
})
require("conform").setup({
	formatters_by_ft = {
		markdown = { "oxfmt", "prettier" },
		mdx = { "oxfmt", "prettier" },
		svelte = { "prettier" },
		javascript = { "oxfmt", "prettier" },
		javascriptreact = { "oxfmt", "prettier" },
		typescript = { "oxfmt", "prettier" },
		typescriptreact = { "oxfmt", "prettier" },
		json = { "oxfmt", "prettier" },
		jsonc = { "oxfmt", "prettier" },
		css = { "oxfmt", "prettier" },
		yaml = { "oxfmt", "prettier" },
		svg = { "oxfmt", "prettier" },
		html = { "oxfmt", "prettier" },
		vue = { "oxfmt", "prettier" },
		lua = { "stylua" },
		astro = { "prettier" },
		sql = { "prettier" },
		go = { "gofmt" },
		gomod = { "gofmt" },
		gowork = { "gofmt" },
		gotmpl = { "gofmt" },
	},
	format_after_save = {
		timeout_ms = 500,
		lsp_fallback = false,
	},
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
