local env = require "env"

---@type NvPluginSpec
return {
  enabled = env.ai_chat == "opencode",
  "NickvanDyke/opencode.nvim",
  dependencies = { { "folke/snacks.nvim" } },
  keys = {
    {
      "<A-;>",
      function()
        require("opencode").ask("@this: ", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "Ask opencode",
    },
    {
      "<C-k>",
      function()
        require("opencode").select()
      end,
      mode = { "n", "x" },
      desc = "Execute opencode action…",
    },
    {
      "<C-.>",
      function()
        require("opencode").toggle()
      end,
      mode = { "n", "t" },
      desc = "Toggle opencode",
    },
    {
      "go",
      function()
        return require("opencode").operator "@this "
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Add range to opencode",
    },
    {
      "goo",
      function()
        return require("opencode").operator "@this " .. "_"
      end,
      mode = "n",
      expr = true,
      desc = "Add line to opencode",
    },
    {
      "<A-l>",
      function()
        return require("opencode").operator "@this " .. "_"
      end,
      mode = "n",
      expr = true,
      desc = "Add line to opencode",
    },
    {
      "<A-l>",
      function()
        return require("opencode").operator "@this "
      end,
      mode = "x",
      expr = true,
      desc = "Add selection to opencode",
    },
    {
      "<S-C-u>",
      function()
        require("opencode").command "session.half.page.up"
      end,
      mode = "n",
      desc = "opencode half page up",
    },
    {
      "<S-C-d>",
      function()
        require("opencode").command "session.half.page.down"
      end,
      mode = "n",
      desc = "opencode half page down",
    },
  },
  init = function()
    vim.g.opencode_opts = {
      provider = {
        enabled = "snacks",
        snacks = {},
      },
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true
  end,
}
