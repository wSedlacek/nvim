---@type NvPluginSpec
return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  event = "LspAttach",
  dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
  config = function()
    vim.opt.updatetime = 200
    require("barbecue").setup {
      create_autocmd = false,
    }

    vim.api.nvim_create_autocmd({ "BufWinEnter", "CursorHold", "BufModifiedSet" }, {
      group = vim.api.nvim_create_augroup("barbecue.updater", {}),
      callback = function()
        require("barbecue.ui").update()
      end,
    })
  end,
}
