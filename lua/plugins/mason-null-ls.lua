---@type NvPluginSpec
return {
  "jay-babu/mason-null-ls.nvim",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim",
  },
  opts = {
    ensure_installed = {
      "lua-language-server",
      "yaml-language-server",
      "helm-ls",
      "stylua",
      "css-lsp",
      "html-lsp",
      "eslint-lsp",
      "typescript-language-server",
      "angular-language-server",
      "prettierd",
      "marksma",
      "nxls",
      "json-lsp",
      "dockerfile-language-server",
      "emmet-ls",
      "biome",
      "typos-lsp",
      "buf-language-server",
      "buf",
      "bash-language-server",
    },
  },
}
