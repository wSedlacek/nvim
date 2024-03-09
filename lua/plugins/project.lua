---@type NvPluginSpec
return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  config = function()
    require("project_nvim").setup {
      detection_methods = { "pattern" },
      patterns = { "nx.json", ".git" },
    }

    require("telescope").load_extension "projects"
  end,
}
