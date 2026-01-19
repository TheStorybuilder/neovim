return {
  "mrcjkb/rustaceanvim",
  version = "^6", -- Recommended to pin to a stable version
  ft = { "rust" },
  opts = {
    -- Explicitly set the path to rust-analyzer
    -- Pass options directly to rust-analyzer
    -- server = {
    --   -- Turn off all inlay hints
    --   inlayHints = {
    --     bindingModeHints = { enable = false },
    --     chainingHints = { enable = false },
    --     closureCaptureHints = { enable = false },
    --     closureParameterHints = { enable = false },
    --     discriminantHints = { enable = false },
    --     fieldOffsetHints = { enable = false },
    --     lifetimeElisionHints = { enable = false },
    --     parameterHints = { enable = false },
    --     typeHints = { enable = false },
    --   },
    -- },
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
