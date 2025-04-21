--- @type NvPluginSpec
return {
  "nvim-tree/nvim-tree.lua",
  opts = {
    disable_netrw = true,
    git = { enable = true },

    renderer = {
      highlight_git = true,
      icons = { show = { git = false } },
    },
    filters = { dotfiles = true },
  },
}
