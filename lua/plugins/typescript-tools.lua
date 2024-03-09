---@type NvPluginSpec
return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  event = "FileType",
  ft = { "ts", "tsx" },
  config = function()
    require("typescript-tools").setup {
      capabilities = require("nvchad.configs.lspconfig").capabilities,
      on_attach = function(client, bufnr)
        require("nvchad.configs.lspconfig").on_attach(client, bufnr)
      end,
      settings = {
        complete_function_calls = false,
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeCompletionsForModuleExports = true,
          quotePreference = "auto",
        },
        tsserver_format_options = {
          allowIncompleteCompletions = false,
          allowRenameOfImportPath = false,
        },
      },
    }
  end,
}
