---@type NvPluginSpec
return {
  "chrisgrieser/nvim-various-textobjs",
  event = "VeryLazy",
  opts = {
    useDefaults = true,
    disabledDefaults = { "%", "r", "R", "s", "S", "w", "e", "b", "ge", "gc" },
  },
}
