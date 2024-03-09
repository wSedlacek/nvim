---@type NvPluginSpec
return {
  "stevearc/oil.nvim",
  event = "UIEnter",
  opts = {
    view_options = { show_hidden = true },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
