local configs = require "nvchad.configs.lspconfig"
local util = require "lspconfig.util"

local nv_on_attach = configs.on_attach
local nv_on_init = configs.on_init
local nv_capabilities = configs.capabilities

local function on_attach(client, bufnr)
  nv_on_attach(client, bufnr)
end

local function on_init(client, bufnr)
  nv_on_init(client, bufnr)
end

local capabilities = vim.tbl_deep_extend("force", nv_capabilities, {})

local servers = {
  "html",
  "cssls",
  "marksman",
  "nxls",
  "sqlls",
  "sourcekit",
  "buf_ls",
  "dockerls",
  "biome",
  "bashls",
  {
    "angularls",
    root_dir = function(bufnr, on_dir)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      local root = util.root_pattern("angular.json", "nx.json", "project.json", "nativescript.config.ts")(fname)
      if root then
        on_dir(root)
      end
    end,
    on_attach = function(client, bufnr)
      -- This conflicts with the tsserver lsp
      client.server_capabilities.renameProvider = false
      on_attach(client, bufnr)
    end,
  },
  {
    "emmet_ls",
    filetypes = { "css", "eruby", "html", "less", "sass", "scss", "svelte", "pug", "vue" },
    init_options = {
      html = {
        options = {
          ["bem.enabled"] = true,
        },
      },
    },
  },
  {
    "jsonls",
    filetypes = { "json" },
    on_attach = function(client, bufnr)
      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false
      on_attach(client, bufnr)
    end,
    settings = {
      documentFormatting = false,
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  {
    "eslint",
    root_dir = function(bufnr, on_dir)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      local root = util.root_pattern(
        ".eslintrc.js",
        ".eslintrc.json",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        ".eslintrc.jsonc",
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs"
      )(fname)
      if root then
        return on_dir(util.root_pattern(".git", ".jj")(fname))
      end

      return nil
    end,
  },
  {
    "typos_lsp",
    init_options = {
      diagnosticSeverity = "Hint",
    },
  },
  {
    "vtsls",
    single_file_support = false,
    root_dir = function(bufnr, on_dir)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      local deno_root = util.root_pattern("deno.json", "deno.jsonc")(fname)
      if deno_root then
        return nil
      end

      on_dir(util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git", ".jj")(fname))
    end,
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
  },
  {
    "denols",
    init_options = {
      lint = true,
      unstable = true,
    },
    single_file_support = false,
    root_dir = function(bufnr, on_dir)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      local root = util.root_pattern("deno.json", "deno.jsonc")(fname)
      if root then
        on_dir(root)
      end
    end,
  },
}

for _, lsp in ipairs(servers) do
  local lsp_name = type(lsp) == "table" and lsp[1] or lsp
  local lsp_config = type(lsp) == "table" and lsp or {}

  if not lsp_config.on_init then
    lsp_config.on_init = on_init
  end

  if not lsp_config.on_attach then
    lsp_config.on_attach = on_attach
  end

  if not lsp_config.capabilities then
    lsp_config.capabilities = capabilities
  end

  if vim.lsp.config then
    vim.lsp.enable(lsp_name)
    vim.lsp.config(lsp_name, lsp_config)
  else
    local lspconfig = require "lspconfig"
    lspconfig[lsp_name].setup(lsp_config)
  end
end
