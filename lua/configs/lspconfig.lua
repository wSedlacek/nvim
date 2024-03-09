local configs = require "nvchad.configs.lspconfig"

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

---@diagnostic disable-next-line: different-requires
local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

require "configs.diagnostics"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "marksman", "nxls", "ocamllsp", "sqlls", "sourcekit", "bufls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.angularls.setup {
  on_init = on_init,
  on_attach = on_attach,
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
      validate = {
        enable = true,
      },
    },
  },
}

lspconfig.eslint.setup {
  on_init = on_init,
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
    on_attach(client, bufnr)
  end,
}

lspconfig.lua_ls.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}
