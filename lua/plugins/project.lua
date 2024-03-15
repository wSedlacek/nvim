---@type NvPluginSpec
return {
  "ahmedkhalf/project.nvim",
  name = "project_nvim",
  config = function(_, opts)
    require("project_nvim").setup(opts)
    -- Projects is empty if opened and seetting up at the same time
    -- so to work around this we open it again and all the data will
    -- be there
    vim.schedule(function()
      vim.cmd "Telescope projects"
    end)
  end,
  opts = {
    detection_methods = { "pattern" },
    patterns = { "nx.json", ".git" },
  },
  keys = {
    { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Telescope Find projects" },
  },
}
