local env = require "env"

--- @type NvPluginSpec
return {
  enabled = env.completion == "cmp",
  "iguanacucumber/magazine.nvim",
  name = "nvim-cmp",
  dependencies = {
    { "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
    { "iguanacucumber/mag-nvim-lua", name = "cmp-nvim-lua" },
    { "iguanacucumber/mag-buffer", name = "cmp-buffer" },
    { "iguanacucumber/mag-cmdline", name = "cmp-cmdline" },
    { "doxnit/cmp-luasnip-choice", opts = { auto_open = true } },
    { "David-Kunz/cmp-npm", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
    { "petertriho/cmp-git", opts = {}, enabled = env.vsc == "git" },
    "https://codeberg.org/FelipeLema/cmp-async-path",
  },
  init = function()
    vim.opt.pumheight = 8
  end,
  config = function(plugin, opts)
    local sources = {
      { name = "nvim_lsp" },
      { name = "npm", keyword_length = 4 },
      { name = "luasnip" },
      { name = "luasnip_choice" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "orgmode" },
    }

    if env.vsc == "git" then
      table.insert(sources, 2, { name = "git" })
    end

    opts.sources = sources
    vim.print(opts)
    require("cmp").setup(opts)
  end,
}
