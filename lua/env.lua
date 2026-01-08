-- Check environment variables for NVIM_AI (possible values, supermaven, copilot, etc.)
local default_ai = "supermaven"
local default_ai_chat = "claudecode"
local default_vsc = "jj"

M = {}
M.ai = os.getenv "NVIM_AI" or default_ai
M.ai_chat = os.getenv "NVIM_AI_CHAT" or default_ai_chat
M.vsc = os.getenv "NVIM_VSC" or default_vsc

return M
