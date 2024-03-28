---@type NvPluginSpec
return {
  "tenxsoydev/karen-yank.nvim",
  event = "VeryLazy",
  opts = {
    mappings = {
      karen = "y",
      invert = false,
      disable = { "s", "S" },
    },
  },
}
