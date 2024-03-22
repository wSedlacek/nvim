--- @type NvPluginSpec
return {
  "zeioth/garbage-day.nvim",
  disabled = true,
  dependencies = "neovim/nvim-lspconfig",
  event = "VeryLazy",
  opts = {
    excluded_lsp_clients = { "null-ls", "copilot" },
  },
}
