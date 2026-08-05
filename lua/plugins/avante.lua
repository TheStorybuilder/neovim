return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    -- Highlight LM Studio as the primary engine
    provider = "openai",
    auto_suggestions_provider = "openai",

    openai = {
      endpoint = "http://127.0.0.1:1234/v1",
      model = "gemma-4-12b", -- Match the model ID running in your LM Studio Server
      api_key_name = "", -- Left empty; LM Studio handles requests locally without keys
      timeout = 30000, -- 30 seconds
      temperature = 0, -- Force deterministic outputs for code & shell syntax fixing
      max_tokens = 8192,
    },

    -- Inject specific instructions to help Gemma-4 resolve tricky syntax errors (.bash_history, loops, etc.)
    system_prompt = [[
      You are an expert software engineer specializing in strict syntax correction, code refactoring, and shell diagnostics.
      When given input (such as code files, scripts, or sequential .bash_history log streams), focus on locating broken syntax, unclosed quotes, malformed control blocks, and unclosed loops.
      Provide highly structural, accurate code updates. Minimize generic conversational text.
    ]],

    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
    },

    mappings = {
      ask = "<leader>aa",
      edit = "<leader>ae",
      refresh = "<leader>ar",
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
    },
  },
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-mini/mini.pick",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
