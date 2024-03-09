---@type NvPluginSpec
return {
  "astephanh/yaml-companion.nvim",
  dependencies = {
    { "neovim/nvim-lspconfig" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
  },
  ft = { "yaml" },
  event = "LspAttach",
  config = function()
    require("telescope").load_extension "yaml_schema"
    local cfg = require("yaml-companion").setup {}
    require("lspconfig")["yamlls"].setup(cfg)
  end,
}
