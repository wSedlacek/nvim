---@type NvPluginSpec
return {
  "kevinhwang91/nvim-ufo",
  event = "BufEnter",
  dependencies = { "kevinhwang91/promise-async" },
  enabled = true,
  opts = {
    provider_selector = function()
      return { "treesitter", "indent" }
    end,
  },
}
