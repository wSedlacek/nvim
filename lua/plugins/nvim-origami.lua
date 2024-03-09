---@type NvPluginSpec
return {
  "chrisgrieser/nvim-origami",
  event = "BufReadPost",
  opts = {
    keepFoldsAcrossSessions = false, -- causes issues with oil.nvim
    pauseFoldsOnSearch = true,
  },
}
