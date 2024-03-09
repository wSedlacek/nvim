---@type NvPluginSpec
return {
  "stevearc/qf_helper.nvim",
  event = { "BufRead", "BufNew" },
  ft = { "qf" },
  opts = {},
}
