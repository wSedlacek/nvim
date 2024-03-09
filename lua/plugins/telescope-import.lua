---@type NvPluginSpec
return {
  "piersolenski/telescope-import.nvim",
  event = "BufRead",
  ft = { "ts", "tsx" },
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("telescope").load_extension "import"
  end,
}
