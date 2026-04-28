-- Add any additional keymaps here
vim.keymap.set("i", "jj", "<Esc>", { noremap = false, desc = "Esc" })
vim.keymap.set("n", "gh", "^", { noremap = false, desc = "Jump to First Char" })
vim.keymap.set("n", "gl", "$", { noremap = false, desc = "Jump to Last Char" })

-- Tmux/window navigation (<C-h/j/k/l>, <C-H/L>) is defined on the
-- vim-tmux-navigator plugin spec at lua/plugins/tmux.lua so lazy.nvim sets
-- them deterministically and triggers the plugin load on first use.
