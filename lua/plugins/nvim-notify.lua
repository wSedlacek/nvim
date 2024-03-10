---@type NvPluginSpec
return {
  "rcarriga/nvim-notify",
  opts = {
    render = "wrapped-compact",
    stages = "slide",
    timeout = 2000,
    top_down = true,
    fps = 90,
  },
}
