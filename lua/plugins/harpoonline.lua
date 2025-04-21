--- @type NvPluginSpec
return {
  "abeldekat/harpoonline",
  version = "*",
  init = function()
    local Extensions = require "harpoon.extensions"
    Extensions.extensions:add_listener {
      ADD = function()
        vim.cmd "redrawtabline"
      end,
      REMOVE = function()
        vim.cmd "redrawtabline"
      end,
      REPLACE = function()
        vim.cmd "redrawtabline"
      end,
      REORDER = function()
        vim.cmd "redrawtabline"
      end,
      POSTION_UPDATED = function()
        vim.cmd "redrawtabline"
      end,
      SELECT = function()
        vim.cmd "redrawtabline"
      end,
      LIST_CHANGE = function()
        vim.cmd "redrawtabline"
      end,
    }
  end,
}
