local env = require "env"

--- @type NvPluginSpec
return {
  enabled = env.ai == "supermaven",
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  cmd = {
    "SupermavenStart",
    "SupermavenStop",
    "SupermavenRestart",
    "SupermavenToggle",
    "SupermavenStatus",
    "SupermavenUseFree",
    "SupermavenUsePro",
    "SupermavenLogout",
    "SupermavenShowLog",
    "SupermavenClearLog",
  },
  config = function()
    require("supermaven-nvim").setup {
      keymaps = {
        accept_suggestion = "<C-cr>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
    }
  end,
}
