--- @type NvPluginSpec
return {
  event = "VeryLazy",
  "folke/snacks.nvim",
  priority = 1000,
  opts = {
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    git = { enabled = false },
    gitbrowse = { enabled = true },
    image = { enabled = false },
    indent = {
      enabled = true,
      only_current = true,
    },
    input = { enabled = true },
    lazygit = { enabled = false },
    notify = { enabled = false },
    notifier = { enabled = false },
    picker = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    scope = { enabled = true },
    scratch = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    terminal = { enabled = false },
    words = { enabled = true },
    zen = { enabled = true },
  },
  init = function()
    local Snacks = require "snacks"
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        if event.data.actions.type == "move" then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
      end,
    })
  end,
}
