-- Map netrw's default <C-l> mapping (refresh the file list) to something that will never be used.
-- This frees <C-l> up for window pane navigation via tmux.nvim.
vim.keymap.set({ "n" }, "<leader><leader><leader><leader><leader><leader>l", "<Plug>NetrwRefresh")
