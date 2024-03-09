---@type NvPluginSpec
return {
  "epwalsh/obsidian.nvim",
  cmd = { "ObsidianToday", "ObsidianYesterday", "ObsidianSearch", "ObsidianQuickSwitch", "ObsidianWorkspace" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/personal",
      },
      {
        name = "work",
        path = "~/Documents/work",
      },
    },
  },
}
