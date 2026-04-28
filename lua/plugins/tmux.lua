return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  -- stylua: ignore
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>",  mode = { "n", "i", "t" }, silent = true, desc = "Window: Left"  },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>",  mode = { "n", "i", "t" }, silent = true, desc = "Window: Down"  },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>",    mode = { "n", "i", "t" }, silent = true, desc = "Window: Up"    },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", mode = { "n", "i", "t" }, silent = true, desc = "Window: Right" },
    { "<C-H>", "<cmd>TmuxNavigateLeft<cr>",  mode = { "n", "i", "t" }, silent = true, desc = "Window: Left"  },
    { "<C-L>", "<cmd>TmuxNavigateRight<cr>", mode = { "n", "i", "t" }, silent = true, desc = "Window: Right" },
  },
}
