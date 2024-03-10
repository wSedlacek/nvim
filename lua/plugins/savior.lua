--- @type NvPluginSpec
return {
  "willothy/savior.nvim",
  dependencies = { "j-hui/fidget.nvim" },
  event = { "InsertEnter", "TextChanged" },
  config = function()
    local savior = require "savior"
    savior.setup {
      events = {
        immediate = {
          "FocusLost",
          "BufLeave",
        },
        deferred = {
          "FocusLost",
        },
        cancel = {
          "InsertEnter",
          "BufWritePost",
          "TextChanged",
        },
      },
      throttle_ms = 0000,
    }
  end,
}
