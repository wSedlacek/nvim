---@type NvPluginSpec
return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {},
  keys = {
    { "<leader>ci", "<cmd>TSToolsRemoveUnusedImports<cr>", desc = "TypeScript Remove Unused Imports" },
    { "<leader>cI", "<cmd>TSToolsAddMissingImports<cr>", desc = "TypeScript Add Missing Imports" },
    { "<leader>rf", "<cmd>TSToolsRenameFile<cr>", desc = "TypeScript Rename File" },
  },
}
