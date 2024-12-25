---@type NvPluginSpec
return {
  "csessh/aoc.nvim",
  session_filepath = "/var/tmp/aoc.txt",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  cmd = {
    "AocGetPuzzleInput",
    "AocGetTodayPuzzleInput",
    "AocClearCache",
    "AocInspectConfig",
  },
}
