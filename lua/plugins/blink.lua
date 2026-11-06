local env = require "env"

local blink_opts = {
  sources = {
    -- opts_extend merges this into NvChad's default list
    default = { "lazydev" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },
}

if env.sidekick_nes then
  blink_opts.keymap = {
    ["<Tab>"] = {
      "snippet_forward",
      function()
        return require("sidekick").nes_jump_or_apply()
      end,
      function()
        return vim.lsp.inline_completion.get()
      end,
      "fallback",
    },
  }
end

--- @type NvPluginSpec[]
return {
  {
    enabled = env.completion == "blink",
    import = "nvchad.blink.lazyspec",
  },
  {
    enabled = env.completion == "blink",
    "saghen/blink.cmp",
    opts = blink_opts,
  },
}
