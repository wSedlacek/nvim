-- Check environment variables for NVIM_AI (possible values, supermaven, copilot, etc.)
local default_ai = "supermaven"
local default_vsc = "jj"

M = {}
M.ai = os.getenv "NVIM_AI" or default_ai
M.vsc = os.getenv "NVIM_VSC" or default_vsc

return M
