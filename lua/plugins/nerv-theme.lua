return {
  {
    "wongmjane/nerv-theme",
    enabled = false,
    dir = "~/.config/nvim/colors/", -- or use git URL when published
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme nerv]])
    end,
  },
}
