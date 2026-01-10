---@type NvPluginSpec
return {
  "yioneko/nvim-vtsls",
  keys = {
    {
      "<leader>lR",
      function()
        if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
          require("vtsls").commands.restart_tsserver()
        end

        vim.diagnostic.reset()
        vim.cmd [[LspRestart]]
      end,
      desc = "LSP Restart Language Server",
    },
    {
      "<leader>ci",
      function()
        require("vtsls").commands.remove_unused_imports()
      end,
      desc = "TypeScript Remove Unused Imports",
    },
    {
      "<leader>cI",
      function()
        require("vtsls").commands.add_missing_imports()
      end,
      desc = "TypeScript Add Missing Imports",
    },
    {
      "<leader>rf",
      function()
        require("vtsls").commands.rename_file()
      end,
      desc = "TypeScript Rename File",
    },
  },
}
