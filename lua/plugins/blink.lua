local env = require "env"

--- @type NvPluginSpec[]
return {
  {
    enabled = env.completion == "blink",
    import = "nvchad.blink.lazyspec",
  },
  {
    enabled = env.completion == "blink",
    "saghen/blink.cmp",
    opts = {
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
    },
  },
}
