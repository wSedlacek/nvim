local env = require "env"

---@type NvPluginSpec
return {
  "NeogitOrg/neogit",
  enabled = env.vsc == "git",
  ft = { "diff" },
  cmd = "Neogit",
  dependencies = {
    "sindrets/diffview.nvim",
    "nvim-lua/plenary.nvim",
  },
  opts = {
    integrations = {
      telescope = true,
      diffview = true,
      snacks = true,
    },
  },
  keys = {
    {
      "<leader>gg",
      function()
        require("neogit").open()
      end,
      desc = "vsc Open Version Control",
    },
    {
      "<leader>gc",
      function()
        require("neogit").open "commit"
      end,
      desc = "vsc commit",
    },
  },
}
