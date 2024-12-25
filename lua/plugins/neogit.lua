---@type NvPluginSpec
return {
  "NeogitOrg/neogit",
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
  -- Switched to Jujitsu
  enabled = false,
}
