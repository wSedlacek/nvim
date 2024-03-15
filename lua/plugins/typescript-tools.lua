---@type NvPluginSpec
return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
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
  keys = {
    { "<leader>ci", "<cmd>TSToolsRemoveUnusedImports<cr>", desc = "TypeScript Remove Unused Imports" },
    { "<leader>cI", "<cmd>TSToolsAddMissingImports<cr>", desc = "TypeScript Add Missing Imports" },
    { "<leader>rf", "<cmd>TSToolsRenameFile<cr>", desc = "TypeScript Rename File" },
  },
}
