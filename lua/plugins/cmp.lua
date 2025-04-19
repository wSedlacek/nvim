--- @type NvPluginSpec
return {
  "iguanacucumber/magazine.nvim",
  name = "nvim-cmp",
  dependencies = {
    { "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
    { "iguanacucumber/mag-nvim-lua", name = "cmp-nvim-lua" },
    { "iguanacucumber/mag-buffer", name = "cmp-buffer" },
    { "iguanacucumber/mag-cmdline", name = "cmp-cmdline" },
    "https://codeberg.org/FelipeLema/cmp-async-path",
  },
  init = function()
    vim.opt.pumheight = 8
  end,
  opts = {
    sources = {
      { name = "nvim_lsp" },
      -- { name = "git" }, -- Switched to Jujitsu
      { name = "npm", keyword_length = 4 },
      { name = "luasnip" },
      { name = "luasnip_choice" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "orgmode" },
    },
  },
}
