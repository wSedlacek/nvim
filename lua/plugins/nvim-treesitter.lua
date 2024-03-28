--- @type NvPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    auto_install = false,
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
      "org",
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
}
