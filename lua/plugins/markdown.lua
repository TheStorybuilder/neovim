return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    require("render-markdown").setup({
      completions = { lsp = { enabled = true } },
    }),
  },
  -- Ensure nvim-treesitter is loaded (LazyVim usually handles this, but good to be explicit)
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { "markdown", "markdown_inline" }, -- Ensure markdown parser is installed
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

    -- Define the autocmd and keymaps only for markdown files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        local ts_utils = require("nvim-treesitter.ts_utils")
        local query = vim.treesitter.query.parse("markdown", "((atx_heading) @header)")

        -- Function to jump to the next header
        local function jump_to_next_header()
          local bufnr = vim.api.nvim_get_current_buf()
          local root = vim.treesitter.get_parser(bufnr):parse()[1]:root()
          local row, col = unpack(vim.api.nvim_win_get_cursor(0))

          local next_node = nil
          for _, node, _ in query:iter_captures(root, 0, row, -1) do
            local node_start_row, _, _, _ = node:range()
            if node_start_row > row then
              next_node = node
              break
            elseif node_start_row == row and node:start() > col then
              next_node = node
              break
            end
          end

          if next_node then
            ts_utils.goto_node(next_node)
          else
            vim.notify("No next markdown header found.", vim.log.levels.INFO, { title = "Markdown Jump" })
          end
        end

        -- Function to jump to the previous header
        local function jump_to_previous_header()
          local bufnr = vim.api.nvim_get_current_buf()
          local root = vim.treesitter.get_parser(bufnr):parse()[1]:root()
          local row, col = unpack(vim.api.nvim_win_get_cursor(0))

          local prev_node = nil
          for _, node, _ in query:iter_captures(root, 0, 0, row) do
            local node_start_row, _, _, _ = node:range()
            if node_start_row < row then
              prev_node = node
            elseif node_start_row == row and node:start() < col then
              prev_node = node
            end
          end

          if prev_node then
            ts_utils.goto_node(prev_node)
          else
            vim.notify("No previous markdown header found.", vim.log.levels.INFO, { title = "Markdown Jump" })
          end
        end

        -- Keymappings
        vim.keymap.set("n", "gj", jump_to_next_header, { noremap = true, desc = "Jump to next Markdown header" })
        vim.keymap.set(
          "n",
          "gk",
          jump_to_previous_header,
          { noremap = true, desc = "Jump to previous Markdown header" }
        )
      end,
    })
  end,
}
