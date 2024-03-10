--- @type NvPluginSpec
return {
  "jdrupal-dev/code-refactor.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "typescript", "javascript" },
  keys = {
    { "<leader>cA", "<cmd>CodeActions all<CR>", desc = "Code actions" },
  },
  opts = {},
}
