local env = require "env"

--- @type NvPluginSpec
return {
  enabled = env.ai == "copilot",
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  cmd = { "Copilot" },
  opts = {
    filetypes = { yaml = true },
    suggestion = {
      enable = true,
      auto_trigger = true,
      keymap = {
        accept = "<c-cr>",
      },
    },
  },
}
