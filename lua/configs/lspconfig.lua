local configs = require "nvchad.configs.lspconfig"

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities
---@diagnostic disable-next-line: different-requires
local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

require "configs.diagnostics"

local servers = {
  "html",
  "cssls",
  "marksman",
  "nxls",
  "ocamllsp",
  "sqlls",
  "sourcekit",
  "bufls",
  "dockerls",
  -- "biome",
  "bashls",
}

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
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = util.root_pattern ".git",
}

lspconfig.typos_lsp.setup {
  on_init,
  on_attach,
  capabilities,
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
      tsserver = {
        globalPlugins = {
          { name = "@monodon/typescript-nx-imports-plugin" },
        },
      },
    },
    typescript = {
      prefrences = {
        quoteStyle = "auto",
      },
    },
  },
}
