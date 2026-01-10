-- Check environment variables for NVIM_AI (possible values, supermaven, copilot, etc.)
local default_ai = "supermaven"
local default_completion = "blink"

-- Helper function to check if a command exists
local function command_exists(cmd)
  local handle = io.popen("command -v " .. cmd .. " 2>/dev/null")
  if handle then
    local result = handle:read "*a"
    handle:close()
    return result ~= ""
  end
  return false
end

-- Check for AI chat command: opencode > claude > copilot (fallback)
local default_ai_chat = "copilot"
if command_exists "opencode" then
  default_ai_chat = "opencode"
elseif command_exists "claude" then
  default_ai_chat = "claude"
end

-- Check for version control command: jj > git (fallback)
local default_vsc = "git"
if command_exists "jj" then
  default_vsc = "jj"
end

M = {}
M.ai = os.getenv "NVIM_AI" or default_ai
M.ai_chat = os.getenv "NVIM_AI_CHAT" or default_ai_chat
M.vsc = os.getenv "NVIM_VSC" or default_vsc
M.completion = os.getenv "NVIM_COMPLETION" or default_completion

return M
