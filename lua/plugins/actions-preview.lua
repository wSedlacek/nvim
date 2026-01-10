---@type NvPluginSpec
return {
  "aznhe21/actions-preview.nvim",
  keys = {
    {
      "<leader>ca",
      function()
        require("actions-preview").code_actions()
      end,
      desc = "LSP Code action",
      mode = { "n", "v" },
    },
  },
  opts = {},
}
