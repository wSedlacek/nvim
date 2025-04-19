---@type NvPluginSpec
return {
  "stevearc/dressing.nvim",
  event = "UIEnter",
  opts = {
    win_options = {
      winhighlight = "NormalFloat:DiagnosticError",
    },
  },
}
