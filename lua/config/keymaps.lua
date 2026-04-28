-- Exit Insert Mode
-- Add any additional keymaps here
vim.keymap.set("i", "jj", "<Esc>", { noremap = false, desc = "Esc" })
vim.keymap.set("n", "gh", "^", { noremap = false, desc = "Jump to First Char" })
vim.keymap.set("n", "gl", "$", { noremap = false, desc = "Jump to Last Char" })

-- Tmux Navigator Mappings (Forced)
local function navigation_map(key, cmd)
  -- Use direct command execution to avoid status bar ghosting
  vim.keymap.set({ "n", "v", "i", "t" }, key, "<cmd>" .. cmd .. "<cr>", { 
    silent = true, 
    nowait = true, 
    desc = "Tmux " .. cmd 
  })
end

-- Apply mappings after a short delay to ensure they win against LazyVim defaults
vim.schedule(function()
  navigation_map("<C-h>", "TmuxNavigateLeft")
  navigation_map("<C-j>", "TmuxNavigateDown")
  navigation_map("<C-k>", "TmuxNavigateUp")
  navigation_map("<C-l>", "TmuxNavigateRight")
  navigation_map("<C-H>", "TmuxNavigateLeft")
  navigation_map("<C-L>", "TmuxNavigateRight")
end)
