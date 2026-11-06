local env = require "env"

-- OpenCode CLI is routed through sidekick.nvim when NVIM_AI_CHAT=opencode.
-- Keep this plugin available only if someone opts into the dedicated integration.
---@type NvPluginSpec
return {
  enabled = env.ai_chat == "opencode-native",
  "NickvanDyke/opencode.nvim",
  dependencies = { { "folke/snacks.nvim" } },
  keys = {
    {
      "<A-;>",
      function()
        require("opencode").ask("@this: ", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "Ask opencode",
    },
    {
      "<C-k>",
      function()
        require("opencode").select()
      end,
      mode = { "n", "x" },
      desc = "Execute opencode action…",
    },
    {
      "<C-.>",
      function()
        require("opencode").toggle()
      end,
      mode = { "n", "t" },
      desc = "Toggle opencode",
    },
  },
  init = function()
    vim.g.opencode_opts = {
      provider = {
        enabled = "snacks",
        snacks = {},
      },
    }
    vim.o.autoread = true
  end,
}
