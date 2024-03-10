--- @type NvPluginSpec
return {
  "HakonHarnes/img-clip.nvim",
  event = "BufEnter",
  opts = {},
  keys = {
    { "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
  },
}
