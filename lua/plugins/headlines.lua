--- @type NvPluginSpec
return {
  "lukas-reineke/headlines.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  -- Markdown previews are handled by markview.nvim
  opts = {
    org = {
      fat_headlines = false,
    },
  },
  ft = { "org" },
}
