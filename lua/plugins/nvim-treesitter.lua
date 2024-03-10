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
      "bash",
      "regex",
    },
    indent = {
      enable = true,
      disable = { "swift", "text" },
    },
    hihglight = {
      enable = false,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    require "configs.treesitter"
  end,
}
