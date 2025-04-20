--- @type NvPluginSpec
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" },
    { "nvim-lua/plenary.nvim" },
  },
  opts = {
    adapters = {
      githubmodels = function()
        return require("codecompanion.adapters").extend("githubmodels", {
          schema = {
            model = {
              default = "gpt-4.1",
            },
          },
        })
      end,
    },
    strategies = {
      chat = { adapter = "githubmodels" },
      inline = { adapter = "githubmodels" },
      cmd = { adapter = "githubmodels" },
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
    { mode = "v", "<D-i>", ":CodeCompanion ", desc = "Inline Code Companion" },
    { "<D-S-i>", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Code Companion" },
    { "<D-C-i>", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Actions" },
    { "<D-M-i>", ":CodeCompanionCmd ", desc = "Code Companion Command" },
  },
}
