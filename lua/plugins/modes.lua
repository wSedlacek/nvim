local colors = require("base46").get_theme_tb "base_30"

---@type NvPluginSpec
return {
  "mvllow/modes.nvim",
  event = "BufEnter",

  opts = {
    colors = {
      copy = colors.yellow,
      delete = colors.red,
      insert = colors.green,
      visual = colors.purple,
    },

    line_opacity = {
      insert = 0,
      delete = 0,
      copy = 0,
    },

    set_cursor = true,
    set_cursorline = false,
    set_number = false,
  },
}
