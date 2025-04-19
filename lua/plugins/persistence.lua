---@type NvPluginSpec
return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    dir = vim.fn.expand(vim.fn.stdpath "state" .. "/sessions/"),
    options = { "buffers", "curdir", "tabpages", "winsize" },
  },
}
