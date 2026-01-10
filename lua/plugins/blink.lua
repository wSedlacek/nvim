local env = require "env"

--- @type NvPluginSpec
return {
  enabled = env.completion == "blink",
  import = "nvchad.blink.lazyspec",
}
