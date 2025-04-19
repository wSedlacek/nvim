--- @type NvPluginSpec
return {
  "Isrothy/neominimap.nvim",
  event = "VeryLazy",
  init = function()
    vim.opt.wrap = false
    vim.opt.sidescrolloff = 36

    vim.g.neominimap = {
      auto_enable = true,
      search = {
        enabled = true,
      },
      winopt = function(opt, bufnr)
        opt.cursorlineopt = "both"
      end,
    }
  end,
}
