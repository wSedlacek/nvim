---@type NvPluginSpec
return {
  "jay-babu/mason-null-ls.nvim",
  event = { "VeryLazy" },
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim",
  },
  opts = {
    ensure_installed = {
      "lua-language-server",
      "stylua",
      "css-lsp",
      "html-lsp",
      "typescript-language-server",
      "angular-language-server",
      "prettierd",
      "marksman",
    },
  },
}
