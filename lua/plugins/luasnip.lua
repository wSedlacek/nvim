--- @type NvPluginSpec
return {
  "L3MON4D3/LuaSnip",
  config = function(_, opts)
    require("luasnip").config.set_config(opts)
    require "nvchad.configs.luasnip"
  end,
}
