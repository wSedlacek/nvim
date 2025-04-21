--- @type NvPluginSpec
return {
  "lukas-reineke/indent-blankline.nvim",
  opts = {
    exclude = {
      filetypes = {
        -- Base
        "help",
        "terminal",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "nvdash",
        "nvcheatsheet",
        "",

        -- User
        "notify",
        "oil",
        "oil_preview",
        "noice",
        "leetcode.nvim",
        "leecode",
      },
    },
  },
}
