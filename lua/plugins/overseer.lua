---@type NvPluginSpec
return {
  "stevearc/overseer.nvim",
  cmd = {
    "OverseerRun",
    "OverseerToggle",
    "OverseerInfo",
    "OverseerBuild",
    "OverseerQuickAction",
    "OverseerTaskAction",
  },
  opts = {
    strategy = "terminal",
    templates = { "builtin" },
  },
  keys = {
    { "<leader>tr", "<cmd>OverseerRun<cr>", desc = "Tasks run" },
    { "<leader>tt", "<cmd>OverseerToggle<cr>", desc = "Tasks toggle" },
    { "<leader>ta", "<cmd>OverseerQuickAction<cr>", desc = "Tasks quick action" },
    { "<leader>ti", "<cmd>OverseerInfo<cr>", desc = "Tasks info" },
  },
}
