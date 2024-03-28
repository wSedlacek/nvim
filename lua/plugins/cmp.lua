--- @type NvPluginSpec
return {
  "hrsh7th/nvim-cmp",
  init = function()
    vim.opt.pumheight = 8
  end,
  opts = {
    sources = {
      { name = "nvim_lsp" },
      { name = "git" },
      { name = "npm", keyword_length = 4 },
      { name = "luasnip" },
      { name = "luasnip_choice" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "orgmode" },
    },
  },
}
