--- @type NvPluginSpec
return {
  "chrisgrieser/nvim-scissors",
  dependencies = "nvim-telescope/telescope.nvim",
  opts = {
    snippetDir = vim.fn.stdpath "config" .. "/lua/snippets/vscode/custom",
  },
  keys = {
    {
      "<leader>se",
      function()
        require("scissors").editSnippet()
      end,
      desc = "Edit snippet",
    },
    {
      "<leader>sa",
      function()
        require("scissors").addNewSnippet()
      end,
      desc = "Add new snippet",
      mode = { "n", "x" },
    },
  },
}
