local configs = require "nvchad.configs.lspconfig"

local nv_on_attach = configs.on_attach
local nv_on_init = configs.on_init
local capabilities = configs.capabilities
---@diagnostic disable-next-line: different-requires
local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

local servers = {
  "html",
  "cssls",
  "marksman",
  "nxls",
  "sqlls",
  "sourcekit",
  "bufls",
  "dockerls",
  "biome",
  "bashls",
}

local function on_attach(client, bufnr)
  nv_on_attach(client, bufnr)
end

local function on_init(client, bufnr)
  nv_on_init(client, bufnr)
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.angularls.setup {
  on_init = on_init,
  on_attach = function(client, bufnr)
    -- This conflicts with the tsserver lsp
    client.server_capabilities.renameProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  root_dir = util.root_pattern("angular.json", "nx.json", "project.json", "nativescript.config.ts"),
}

lspconfig.emmet_ls.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "css", "eruby", "html", "less", "sass", "scss", "svelte", "pug", "vue" },
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
      },
    },
  },
}

lspconfig.jsonls.setup {
  on_init = on_init,
  on_attach = function(client, buffer)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    on_attach(client, buffer)
  end,
  capabilities = capabilities,
  filetypes = { "json" },
  settings = {
    documentFormatting = false,
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}

lspconfig.eslint.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = util.root_pattern ".git",
}

lspconfig.typos_lsp.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    diagnosticSeverity = "Hint",
  },
}

lspconfig.vtsls.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = util.root_pattern ".git",
  filetypes = { "angular", "typescript", "typescriptreact", "javascript", "javascriptreact" },
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      preferences = {
        quoteStyle = "auto",
      },
    },
  },
}
