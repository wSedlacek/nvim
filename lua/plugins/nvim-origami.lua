---@type NvPluginSpec
return {
  "chrisgrieser/nvim-origami",
  event = "BufReadPost",
  opts = {
    pauseFoldsOnSearch = true,
    autoFold = {
      enabled = false,
    },
  },
  init = function()
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldnestmax = 0
    vim.o.foldenable = true
    vim.o.foldmethod = "indent"
  end,
}
