---@type NvPluginSpec
return {
  "chrisgrieser/nvim-spider",
  event = "VeryLazy",
  keys = {
    {
      "w",
      mode = { "n", "o", "x" },
      function()
        require("spider").motion "w"
      end,
      desc = "Next word",
    },
    {
      "e",
      mode = { "n", "o", "x" },
      function()
        require("spider").motion "e"
      end,
      desc = "Next end word",
    },
    {
      "b",
      mode = { "n", "o", "x" },
      function()
        require("spider").motion "b"
      end,
      desc = "Back word",
    },
    {
      "ge",
      mode = { "n", "o", "x" },
      function()
        require("spider").motion "ge"
      end,
      desc = "Back word (inclusive)",
    },
  },
}
