return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      elixir = { "mix" },
      eelixir = { "mix" },
      heex = { "mix" },
      surface = { "mix" },
      -- Add other file types as needed
    },
    formatters = {
      prettier = {
        prepend_args = { "--single-quote", "--trailing-comma", "all" },
      },
    },
  },
}
