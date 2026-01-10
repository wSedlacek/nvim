---@type NvPluginSpec
return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  keys = {
    { "<leader>ss", "<cmd>lua require('persistence').load()<cr>", desc = "Reload last session for dir" },
    { "<leader>sl", "<cmd>lua require('persistence').load({ last = true })<cr>", desc = "Restore last session" },
    { "<leader>sQ", "<cmd>lua require('persistence').stop()<cr>", desc = "Quit without saving session" },
  },
  opts = {
    dir = vim.fn.expand(vim.fn.stdpath "state" .. "/sessions/"),
    options = { "buffers", "curdir", "tabpages", "winsize" },
  },
}
