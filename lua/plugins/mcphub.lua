local env = require "env"

--- @type NvPluginSpec
return {
  "ravitemer/mcphub.nvim",
  enabled = env.ai_chat == "copilot",
  dependencies = { "nvim-lua/plenary.nvim" },
  build = "bundled_build.lua",
  cmd = { "MCPHub" },
  keys = {
    { "<leader>aM", "<cmd>MCPHub<cr>", desc = "MCP Hub" },
  },
  opts = {
    auto_approve = false,
    extensions = {
      codecompanion = { enabled = true, show_result_in_chat = true },
    },
  },
}
