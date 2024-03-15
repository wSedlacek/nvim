--- @type NvPluginSpec
return {
  "nvim-tree/nvim-tree.lua",
  opts = {
    git = { enable = false },

    renderer = {
      highlight_git = true,
      icons = { show = { git = false } },
    },
    filters = { dotfiles = true },
  },
}
