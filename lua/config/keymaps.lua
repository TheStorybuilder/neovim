-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Exit Insert Mode
-- Add any additional keymaps here
vim.keymap.set("i", "jj", "<Esc>", { noremap = false, desc = "Esc" })
vim.keymap.set("n", "gh", "^", { noremap = false, desc = "Jump to First Char" })
vim.keymap.set("n", "gl", "$", { noremap = false, desc = "Jump to Last Char" })
