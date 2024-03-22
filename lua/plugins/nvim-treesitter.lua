--- @type NvPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "vim",
      "vimdoc",
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
      "helm",
      "proto",
    },
    indent = {
      enable = true,
      disable = { "swift", "text" },
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    require "configs.treesitter"
  end,
}
