local env = require "env"

-- Copilot inline + NES are handled by Copilot LSP + sidekick.nvim when NVIM_AI=copilot.
-- This stub keeps the old zbirenbaum/copilot.lua plugin disabled to avoid dual LSPs.
---@type NvPluginSpec
return {
  enabled = false,
  "zbirenbaum/copilot.lua",
  cond = function()
    return env.ai == "copilot"
  end,
}
