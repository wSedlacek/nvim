---@type NvPluginSpec
return {
  "topaxi/gh-actions.nvim",
  enabled = false,
  cmd = "GhActions",
  build = "make",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  event = "VeryLazy",
  opts = {},
}
