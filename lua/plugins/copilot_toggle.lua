return {
  "zbirenbaum/copilot.lua", -- Ensure the plugin is loaded
  event = "VeryLazy",
  keys = {
    {
      "<leader>at",
      function()
        -- Check if copilot.lua is loaded
        -- local copilot = require("copilot")
        local copilot_client = require("copilot.client")
        local copilot_command = require("copilot.command")

        local status = copilot_client.is_disabled()
        -- Check the current status
        if status then
          -- If disabled, enable it
          copilot_command.enable()
          vim.notify("Copilot suggestions enabled.", vim.log.levels.INFO)
        else
          -- If enabled, disable it
          copilot_command.disable()
          vim.notify("Copilot suggestions disabled.", vim.log.levels.INFO)
        end
      end,
      mode = { "n", "i" },
      desc = "Toggle Copilot Suggestions",
    },
  },
}
