---@type NvPluginSpec
return {
  "MagicDuck/grug-far.nvim",
  cmd = { "GrugFar", "GrugFarWithin" },
  opts = {
    headerMaxWidth = 80,
  },
  keys = {
    {
      "<leader>`",
      function()
        require("grug-far").open()
      end,
      desc = "Search and replace",
    },
    {
      "<leader>~",
      function()
        require("grug-far").open { prefills = { search = vim.fn.expand "<cword>" } }
      end,
      desc = "Search and replace word",
    },
    {
      "<leader>`",
      function()
        require("grug-far").with_visual_selection()
      end,
      mode = "v",
      desc = "Search and replace selection",
    },
  },
}
