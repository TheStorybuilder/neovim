return {
  "benomahony/uv.nvim",
  config = function()
    require("uv").setup({
      -- Add your custom configuration here
      -- For example, you can set the default filetype for new files
      default_filetype = "markdown",
      -- You can also set up key mappings
      mappings = {
        ["<leader>u"] = { "<cmd>UvOpen<cr>", desc = "Open UV" },
        ["<leader>c"] = { "<cmd>UvClose<cr>", desc = "Close UV" },
      },
    })
  end,
}
