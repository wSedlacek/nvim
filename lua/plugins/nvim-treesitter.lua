--- @type NvPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "vim",
      "lua",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "markdown",
      "markdown_inline",
      "swift",
    },
    indent = {
      enable = true,
      disable = { "swift", "text" },
    },
    hihglight = {
      enable = false,
    },
  },
  event = "VeryLazy",
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "syntax")
    require("nvim-treesitter.configs").setup(opts)
    require "configs.treesitter"
  end,
}
