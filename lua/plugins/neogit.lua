local env = require "env"

---@type NvPluginSpec
return {
  "NeogitOrg/neogit",
  enabled = env.vsc == "jj",
  ft = { "diff" },
  cmd = "Neogit",
  dependencies = {
    "sindrets/diffview.nvim",
    "nvim-lua/plenary.nvim",
  },
  opts = {
    signs = { section = { "", "" }, item = { "", "" } },
    disable_commit_confirmation = true,
    integrations = { diffview = true },
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
    {
      "<leader>gp",
      function()
        require("neogit").open "push"
      end,
      desc = "vsc push",
    },
    {
      "<leader>gr",
      function()
        require("neogit").open "rebase"
      end,
      desc = "vsc rebase",
    },
  },
}
