local treesitter_configs = require("nvim-treesitter.configs")

treesitter_configs.setup {
  -- one of "all", "language", or a list of languages
  ensure_installed = {},
  highlight = {
    enable = true,

    -- list of language that will be disabled
    disable = {'php'},
  },
  indent = {
    enable = true,
  },
}
