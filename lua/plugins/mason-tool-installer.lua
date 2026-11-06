local env = require "env"

local ensure_installed = {
  "angular-language-server",
  "bash-language-server",
  "biome",
  "buf",
  "buf-language-server",
  "css-lsp",
  "dockerfile-language-server",
  "emmet-ls",
  "eslint-lsp",
  "hadolint",
  "helm-ls",
  "html-lsp",
  "json-lsp",
  "lua-language-server",
  "markdownlint",
  "marksman",
  "nxls",
  "prettierd",
  "stylua",
  "swiftlint",
  "typescript-language-server",
  "typos-lsp",
  "vtsls",
  "yaml-language-server",
}

if env.ai == "copilot" then
  ensure_installed[#ensure_installed + 1] = "copilot-language-server"
end

---@type NvPluginSpec
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
  },
  opts = {
    ensure_installed = ensure_installed,
    auto_update = false,
    run_on_start = true,
    start_delay = 3000,
    debounce_hours = 24,
    integrations = {
      ["mason-lspconfig"] = true,
      ["mason-null-ls"] = false,
      ["mason-nvim-dap"] = true,
    },
  },
}
