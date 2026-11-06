-- NVIM_AI: supermaven | copilot
--   supermaven → Supermaven ghost-text completions
--   copilot    → Copilot LSP inline completions + Sidekick NES
--
-- NVIM_AI_CHAT: sidekick CLI tool name, codecompanion, or copilot-agent
--   opencode | claude | copilot | codex | cursor | gemini | grok |
--   aider | crush | qwen | pi | amazon_q | codecompanion | copilot-agent
--   Aliases: claudecode → claude, copilot-cli → copilot
--
-- NVIM_COPILOT_AGENT: 1/0 to force enable/disable copilot-agent.nvim
--   (defaults on when Copilot CLI / @github/copilot is available, or AI=copilot)
--
-- NVIM_VSC: git | jj
-- NVIM_COMPLETION: blink | cmp

local function command_exists(cmd)
  local handle = io.popen("command -v " .. cmd .. " 2>/dev/null")
  if handle then
    local result = handle:read "*a"
    handle:close()
    return result ~= ""
  end
  return false
end

--- Sidekick CLI tool names (see folke/sidekick.nvim sk/cli/)
local sidekick_tools = {
  aider = true,
  amazon_q = true,
  claude = true,
  codex = true,
  copilot = true,
  crush = true,
  cursor = true,
  gemini = true,
  grok = true,
  opencode = true,
  pi = true,
  qwen = true,
}

--- Normalize NVIM_AI_CHAT aliases to canonical names
local chat_aliases = {
  claudecode = "claude",
  ["copilot-cli"] = "copilot",
}

--- Preferred chat backends when NVIM_AI_CHAT is unset (first installed wins)
local chat_preference = {
  { env = "opencode", bin = "opencode" },
  { env = "claude", bin = "claude" },
  { env = "copilot", bin = "copilot" },
  { env = "codex", bin = "codex" },
  { env = "cursor", bin = "cursor" },
  { env = "gemini", bin = "gemini" },
  { env = "grok", bin = "grok" },
  { env = "aider", bin = "aider" },
}

local default_ai = "supermaven"
local default_completion = "blink"

local default_ai_chat = "codecompanion"
for _, item in ipairs(chat_preference) do
  if command_exists(item.bin) then
    default_ai_chat = item.env
    break
  end
end

local default_vsc = "git"
if command_exists "jj" then
  default_vsc = "jj"
end

local M = {}
M.ai = os.getenv "NVIM_AI" or default_ai
M.vsc = os.getenv "NVIM_VSC" or default_vsc
M.completion = os.getenv "NVIM_COMPLETION" or default_completion

local raw_chat = os.getenv "NVIM_AI_CHAT" or default_ai_chat
M.ai_chat = chat_aliases[raw_chat] or raw_chat

--- Sidekick tool name for CLI chat, or nil when using CodeCompanion / copilot-agent
M.ai_chat_tool = nil
if M.ai_chat == "codecompanion" or M.ai_chat == "copilot-agent" then
  M.ai_chat_tool = nil
elseif sidekick_tools[M.ai_chat] then
  M.ai_chat_tool = M.ai_chat
else
  vim.schedule(function()
    vim.notify(
      ("Unknown NVIM_AI_CHAT=%q (expected a sidekick tool, codecompanion, or copilot-agent)"):format(M.ai_chat),
      vim.log.levels.WARN,
      { title = "env" }
    )
  end)
end

M.sidekick_nes = M.ai == "copilot"
M.sidekick_chat = M.ai_chat_tool ~= nil
M.sidekick = M.sidekick_nes or M.sidekick_chat

-- Copilot Agent (SDK-native agentic chat). Force with NVIM_COPILOT_AGENT=1/0.
local agent_override = os.getenv "NVIM_COPILOT_AGENT"
if agent_override == "0" or agent_override == "false" then
  M.copilot_agent = false
elseif agent_override == "1" or agent_override == "true" then
  M.copilot_agent = true
else
  M.copilot_agent = M.ai == "copilot"
    or M.ai_chat == "copilot"
    or M.ai_chat == "copilot-agent"
    or command_exists "copilot"
end

return M
