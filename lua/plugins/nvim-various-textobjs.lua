---@type NvPluginSpec
return {
  "chrisgrieser/nvim-various-textobjs",
  event = "VeryLazy",
  opts = {
    useDefaultKeymaps = true,
    disabledKeymaps = { "%", "r", "R", "s", "S", "w", "e", "b", "ge", "gc" },
  },
}
