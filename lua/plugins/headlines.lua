--- @type NvPluginSpec
return {
  "lukas-reineke/headlines.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  opts = {
    markdown = {},
    org = {
      fat_headlines = false,
    },
  },
  ft = { "markdown", "org" },
}
