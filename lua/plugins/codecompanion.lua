--- @type NvPluginSpec
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" },
    { "nvim-lua/plenary.nvim" },
  },
  opts = {
    strategies = {
      chat = { adapter = "copilot" },
      inline = { adapter = "copilot" },
    },
    opts = {
      -- log_level = "DEBUG",
    },
    display = {
      action_palette = {
        width = 95,
        height = 10,
        provider = "telescope",
        opts = {
          show_default_actions = true,
          show_default_prompt_library = true,
        },
      },
    },
  },
  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionCmd",
  },
  keys = {
    { "<D-i>", ":CodeCompanion ", desc = "Inline Code Companion" },
    { mode = "v", "<D-i>", ":CodeCompanion cool", desc = "Inline Code Companion" },
    { "<D-S-i>", "<cmd>CodeCompanionChat<CR>", desc = "Code Companion" },
    { "<D-M-i>", ":CodeCompanionCmd ", desc = "Code Companion Command" },
  },
}
