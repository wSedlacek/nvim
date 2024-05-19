---@type NvPluginSpec
return {
  "nvim-pack/nvim-spectre",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "grapp-dev/nui-components.nvim",
      dependencies = {
        "MunifTanjim/nui.nvim",
      },
    },
  },
  opts = {},
  cmd = { "Spectre" },
  keys = {
    {
      mode = "n",
      "<leader>`",
      function()
        require("pickers.spectre").toggle()
      end,
      desc = "Toggle Spectre",
    },
    {
      mode = "n",
      "<leader>~",
      function()
        require("pickers.spectre").toggle { focus = true }
      end,
      desc = "Focus Spectre",
    },
  },
}
