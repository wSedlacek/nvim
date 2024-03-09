---@type NvPluginSpec
return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "TroubleToggle", "Trouble", "TodoTroube" },
  opts = {
    mode = "document_diagnostics",
  },
}
