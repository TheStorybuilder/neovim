return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "LazyFile", "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(buffer)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, nowait = true })
        end

      -- stylua: ignore start
      -- Navigation for hunks (can remain as ]h / [h if you like)
      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, "Next Hunk")
      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, "Prev Hunk")
      map("n", "]H", function() gitsigns.nav_hunk("last") end, "Last Hunk")
      map("n", "[H", function() gitsigns.nav_hunk("first") end, "First Hunk")

      -- GitSigns-specific commands using <leader>gitsigns prefix
      map({ "n", "v" }, "<leader>hS", gitsigns.stage_hunk, "Stage Hunk") -- <leader>gs + s
      map({ "n", "v" }, "<leader>hH", gitsigns.reset_hunk, "Reset Hunk") -- <leader>gs + r
      map({ "n", "v" }, "<leader>hp", gitsigns.preview_hunk, "Preview Hunk") -- <leader>gs + p
      map("n", "<leader>gsS", gitsigns.stage_buffer, "Stage Buffer") -- <leader>gs + Shift+S
      -- map("n", "<leader>gsu", gitsigns.undo_stage_hunk, "Undo Stage Hunk") -- <leader>gs + u
      map("n", "<leader>hS", gitsigns.reset_buffer, "Reset Buffer") -- <leader>gs + Shift+R
      map("n", "<leader>hi", gitsigns.preview_hunk_inline, "Preview Hunk Inline") -- <leader>gs + i (for inline)
      map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, "Blame Line") -- <leader>gs + b
      map("n", "<leader>hB", function() gitsigns.blame() end, "Blame Buffer") -- <leader>gs + Shift+B
      map("n", "<leader>hd", gitsigns.diffthis, "Diff This") -- <leader>gs + d
      map("n", "<leader>hD", function() gitsigns.diffthis("~") end, "Diff This ~") -- <leader>gs + Shift+D

      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  {
    "gitsigns.nvim",
    opts = function()
      Snacks.toggle({
        name = "Git Signs",
        get = function()
          return require("gitsigns.config").config.signcolumn
        end,
        set = function(state)
          require("gitsigns").toggle_signs(state)
        end,
      }):map("<leader>uG")
    end,
  },
}
