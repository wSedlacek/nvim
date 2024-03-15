---@type NvPluginSpec
return {
  url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    require("lsp_lines").setup()
    require("lsp_lines").toggle()
  end,
  keys = {
    {
      "<leader>lD",
      function()
        require("lsp_lines").toggle()
      end,
      desc = "LSP Toggle inline diagnostics",
    },
  },
}
