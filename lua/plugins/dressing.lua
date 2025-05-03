---@type NvPluginSpec
return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    win_options = {
      winhighlight = "NormalFloat:DiagnosticError",
    },
  },
}
