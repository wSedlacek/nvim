---@type NvPluginSpec
return {
  "hedyhli/outline.nvim",
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    { "<leader>O", "<cmd>Outline<cr>", desc = "Toggle Outline" },
  },
  opts = {},
}
