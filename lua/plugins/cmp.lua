return {
  {
    "hrsh7th/nvim-cmp",
    config = function(_, opts)
      local cmp = require("cmp")

      -- 1. Configure the completion and documentation windows
      opts.window = {
        completion = cmp.config.window.bordered({
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          winhighlight = "Normal:Pmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
          col_offset = -3,
          side_padding = 0,
        }),
        documentation = cmp.config.window.bordered({
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder,CursorLine:PmenuSel,Search:None",
          max_height = 30,
          max_width = 50,
        }),
      }

      -- 2. Pass opts into setup
      cmp.setup(opts)

      -- 3. Function to set hardcoded cmp colors
      local function set_cmp_colors()
        -- Completion menu background and text
        vim.api.nvim_set_hl(0, "Pmenu", { bg = "#4c4c8c", fg = "#cdd6f4" })

        -- Selected item background and text
        vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#89b4fa", fg = "#11111b", bold = true })

        -- Scrollbar
        vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#767676" })
        vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#45475a" })

        -- Match highlights (matching characters typed)
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#f38ba8", bold = true })
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#f38ba8", bold = true })

        -- Documentation body
        vim.api.nvim_set_hl(0, "CmpDoc", { bg = "#4c4c8c", fg = "#cdd6f4" })

        -- Window borders
        vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#89b4fa", bg = "#4c4c8c" })
        vim.api.nvim_set_hl(0, "CmpDocBorder", { fg = "#89b4fa", bg = "#4c4c8c" })
      end

      -- Apply immediately
      set_cmp_colors()

      -- Re-apply whenever the colorscheme changes so it won't be overridden
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = set_cmp_colors,
      })
    end,
  },
}
