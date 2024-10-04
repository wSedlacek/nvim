--- @type NvPluginSpec
return {
  enabled = false,
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  opts = {
    filetypes = { yaml = true },
    suggestion = {
      enable = true,
      auto_trigger = true,
      keymap = {
        accept = "<c-cr>",
      },
    },
  },
}
