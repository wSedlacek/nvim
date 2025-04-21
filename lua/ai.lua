-- Check environment variables for NVIM_AI (possible values, supermaven, copilot, etc.)
local default_ai = "supermaven"

M = {}
M.default = os.getenv "NVIM_AI" or default_ai

return M
