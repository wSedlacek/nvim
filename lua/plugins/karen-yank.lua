---@type NvPluginSpec
return {
  "tenxsoydev/karen-yank.nvim",
  event = "BufEnter",
  opts = {
    mappings = {
      karen = "y",
      invert = false,
      disable = { "s", "S" },
    },
  },
}
