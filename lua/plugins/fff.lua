---@type NvPluginSpec
return {
  "dmtrKovalenko/fff",
  lazy = false,
  build = function()
    require("fff.download").download_or_build_binary()
  end,
  opts = {
    debug = {
      enabled = false,
      show_scores = false,
    },
  },
  keys = {
    {
      "<leader>ff",
      function()
        require("fff").find_files()
      end,
      desc = "FFF Find files",
    },
    {
      "<leader>fw",
      function()
        require("fff").live_grep()
      end,
      desc = "FFF Live grep",
    },
    {
      "<leader>fW",
      function()
        require("fff").live_grep_under_cursor()
      end,
      mode = { "n", "x" },
      desc = "FFF Grep word/selection",
    },
    {
      "<leader>fz",
      function()
        require("fff").live_grep { grep = { modes = { "fuzzy", "plain" } } }
      end,
      desc = "FFF Fuzzy grep",
    },
  },
}
