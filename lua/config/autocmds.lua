-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Tell tmux when this pane is running nvim, so the smart pane-navigation
-- bindings in ~/.tmux.conf can dispatch C-h/j/k/l correctly even when nvim
-- is launched under wrappers (Kiro, Amazon Q, etc.) that mask the foreground
-- process name from `ps`.
local function trim(s)
  return (s or ""):gsub("^%s+", ""):gsub("%s+$", "")
end

local function tmux_pane_id()
  local pane = trim(vim.env.TMUX_PANE)
  if pane ~= "" then
    return pane
  end
  -- Wrappers like the Kiro CLI strip $TMUX_PANE from child envs; ask tmux.
  local out = vim.fn.system({ "tmux", "display-message", "-p", "#{pane_id}" })
  if vim.v.shell_error ~= 0 then
    return nil
  end
  out = trim(out)
  return out ~= "" and out or nil
end

local function inside_tmux()
  if trim(vim.env.TMUX) ~= "" then
    return true
  end
  -- $TMUX may also be stripped by wrappers; treat tmux as available iff
  -- `tmux display-message` succeeds.
  vim.fn.system({ "tmux", "display-message", "-p", "#{pane_id}" })
  return vim.v.shell_error == 0
end

local function set_tmux_is_vim(value)
  if not inside_tmux() then
    return
  end
  local pane = tmux_pane_id()
  if not pane then
    vim.schedule(function()
      vim.notify("tmux @is_vim: could not resolve pane id", vim.log.levels.WARN)
    end)
    return
  end
  local args = value
      and { "tmux", "set-option", "-pt", pane, "@is_vim", "yes" }
    or { "tmux", "set-option", "-put", pane, "@is_vim" }
  local out = vim.fn.system(args)
  if vim.v.shell_error ~= 0 then
    vim.schedule(function()
      vim.notify("tmux @is_vim update failed: " .. (out or ""), vim.log.levels.WARN)
    end)
  end
end

local tmux_is_vim = vim.api.nvim_create_augroup("TmuxIsVim", { clear = true })

-- Set @is_vim while nvim is alive in this pane. We deliberately do NOT clear
-- on FocusLost: tmux sends focus-out events whenever nvim hands the pty to a
-- child (`:!cmd`, terminal jobs, popups), and clearing on those flips off the
-- pane-navigation flag mid-session. FocusGained is kept as a re-arm safety net.
vim.api.nvim_create_autocmd({ "VimEnter", "VimResume", "FocusGained" }, {
  group = tmux_is_vim,
  callback = function()
    set_tmux_is_vim(true)
  end,
})

vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
  group = tmux_is_vim,
  callback = function()
    set_tmux_is_vim(false)
  end,
})

-- LazyVim sources this file at VeryLazy, which fires AFTER VimEnter, so the
-- VimEnter autocmd above wouldn't run for the current session. Call once now
-- so @is_vim is set immediately on every nvim startup.
set_tmux_is_vim(true)

--Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

--Resize Split if Window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("ResizeSplit", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

--Wrap and check for spelling in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("WrapSpell", { clear = true }),
  pattern = { "text", "markdown", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})

--Fix conceallevel for json filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("ConcealJson", { clear = true }),
  pattern = { "json", "jsonc" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})
