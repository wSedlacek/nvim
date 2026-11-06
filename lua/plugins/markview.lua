---@type NvPluginSpec
return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  priority = 49,
  opts = {
    preview = {
      icon_provider = "devicons",
      filetypes = { "markdown", "md", "rmd", "quarto" },
    },
  },
}
