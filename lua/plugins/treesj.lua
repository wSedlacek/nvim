---@type NvPluginSpec
return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  cmd = { "TSJToggle" },
  keys = {
    { "<leader>cj", "<cmd>lua require('treesj').toggle()<cr>", desc = "Open block" },
  },
  opts = { use_default_keymaps = false },
}
