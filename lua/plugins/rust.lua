return {
  "mrcjkb/rustaceanvim",
  version = "^6", -- Recommended to pin to a stable version
  ft = { "rust" },
  opts = {
    -- Explicitly set the path to rust-analyzer
    tools = {
      rust_analyzer = {
        server = {
          cmd = { "/opt/homebrew/opt/rustup/bin/rust-analyzer" }, -- Your specific path
        },
      },
    },
    -- Other rustaceanvim options...
  },
}
