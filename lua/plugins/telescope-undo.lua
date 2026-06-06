---@type NvPluginSpec
return {
  "debugloop/telescope-undo.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  keys = {
    { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Telescope Undo history" },
  },
  config = function()
    require("telescope").load_extension "undo"
  end,
}
