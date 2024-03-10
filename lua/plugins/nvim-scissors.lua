--- @type NvPluginSpec
return {
  "chrisgrieser/nvim-scissors",
  dependencies = "nvim-telescope/telescope.nvim",
  opts = {
    snippetDir = vim.fn.stdpath "config" .. "/lua/snippets/vscode/custom",
  },
  keys = {
    "<leader>sa",
    "<leader>se",
  },
}
