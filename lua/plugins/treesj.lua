---@type NvPluginSpec
return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  cmd = { "TSJToggle" },
  opts = { use_default_keymaps = false },
}
