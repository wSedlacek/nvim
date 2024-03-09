---@type NvPluginSpec
return {
  "rcarriga/nvim-notify",
  opts = {
    render = "compact", -- default, compact, minimal, simple
    stages = "slide", -- fade, fade_in_slide_out, slide, static
    timeout = 1000,
    top_down = true,
    fps = 60,
  },
}
