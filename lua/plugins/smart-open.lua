---@type NvPluginSpec
return {
  "danielfalk/smart-open.nvim",
  branch = "0.2.x",
  config = function()
    require("telescope").load_extension "smart_open"
  end,
  dependencies = { "kkharji/sqlite.lua" },
  keys = {
    {
      "<leader><leader>",
      function()
        require("telescope").extensions.smart_open.smart_open {
          cwd_only = true,
          filename_first = false,
        }
      end,
      desc = "Telescope Smart Open",
    },
  },
}
