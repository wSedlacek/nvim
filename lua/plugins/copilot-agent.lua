local env = require "env"

-- copilot-agent.nvim currently vendors copilot-sdk/go v0.3.0, which expects
-- PingResponse.timestamp as int64. @github/copilot >= ~1.0.51 returns ISO-8601
-- strings and breaks startup. Keep a plugin-local CLI pin under stdpath("data").
local COPILOT_CLI_PIN = "1.0.50"

local function cli_data_root()
  return vim.fn.stdpath "data" .. "/copilot-agent-cli"
end

local function pinned_cli_loader()
  return cli_data_root() .. "/node_modules/@github/copilot/npm-loader.js"
end

--- Resolve a Copilot CLI JS entrypoint compatible with the Go SDK bridge.
--- Homebrew's native `copilot` binary is not enough.
local function copilot_cli_path()
  local pinned = pinned_cli_loader()
  if vim.uv.fs_stat(pinned) then
    return pinned
  end
  return nil
end

local function ensure_pinned_cli()
  local loader = pinned_cli_loader()
  if vim.uv.fs_stat(loader) then
    return true
  end

  local npm = vim.fn.exepath "npm"
  if npm == "" then
    return false
  end

  local root = cli_data_root()
  vim.fn.mkdir(root, "p")
  local result = vim
    .system({ npm, "i", "--prefix", root, "@github/copilot@" .. COPILOT_CLI_PIN }, { text = true })
    :wait()
  return result.code == 0 and vim.uv.fs_stat(loader) ~= nil
end

---@type NvPluginSpec
return {
  "ray-x/copilot-agent.nvim",
  -- origin/master is currently incomplete (missing render/events split modules).
  -- Use the harness branch until master is fixed.
  branch = "harness",
  enabled = env.copilot_agent,
  build = function(plugin)
    -- Prefer building from source so the binary matches harness Lua.
    -- Also ensure the pinned Copilot CLI runtime is present.
    ensure_pinned_cli()

    local root = (plugin and plugin.dir) or (vim.fn.stdpath "data" .. "/lazy/copilot-agent.nvim")
    local out = root .. "/bin/copilot-agent"
    vim.fn.mkdir(root .. "/bin", "p")

    local go = vim.fn.exepath "go"
    if go ~= "" then
      local result = vim
        .system({ go, "build", "-o", out, "." }, {
          cwd = root .. "/server",
          env = vim.tbl_extend("force", vim.fn.environ(), { GOTOOLCHAIN = "auto" }),
          text = true,
        })
        :wait()
      if result.code == 0 and vim.fn.executable(out) == 1 then
        return
      end
      vim.notify(
        "copilot-agent: go build failed, falling back to :CopilotAgentInstall\n"
          .. (result.stderr or result.stdout or ""),
        vim.log.levels.WARN
      )
    end

    require("copilot_agent").install_binary()
  end,
  cmd = {
    "CopilotAgentInstall",
    "CopilotAgentDashboard",
    "CopilotAgentChat",
    "CopilotAgentChatToggle",
    "CopilotAgentChatFocus",
    "CopilotAgentAsk",
    "CopilotAgentMode",
    "CopilotAgentCompose",
    "CopilotAgentPromoteToCompose",
    "CopilotAgentNewSession",
    "CopilotAgentSwitchSession",
    "CopilotAgentModel",
    "CopilotAgentStatus",
    "CopilotAgentStart",
    "CopilotAgentServerStart",
    "CopilotAgentLsp",
  },
  dependencies = {
    { "folke/snacks.nvim", optional = true },
    { "sindrets/diffview.nvim", optional = true },
  },
  opts = function()
    ensure_pinned_cli()
    local cli = copilot_cli_path()
    local service_env = {}
    if cli then
      service_env.COPILOT_CLI_PATH = cli
    end

    local plugin_root = vim.fn.stdpath "data" .. "/lazy/copilot-agent.nvim"
    local bin = plugin_root .. "/bin/copilot-agent"
    local service_command = vim.fn.executable(bin) == 1 and { bin } or nil

    return {
      permission_mode = "approve-reads",
      notify = true,
      default_provider = "copilot",
      service = {
        auto_start = true,
        detach = true,
        command = service_command,
        env = next(service_env) and service_env or nil,
        startup_timeout_ms = 15000,
      },
      lsp = {
        enabled = true,
      },
      chat = {
        title = "Copilot Agent",
        render_markdown = false, -- markview/treesitter; avoid render-markdown dependency
        file_picker = "snacks",
        diff_cmd = vim.fn.executable "delta" == 1 and { "delta" } or false,
        diff_review = true,
        activity_view = "hover",
        activity_diff_tool = "diffview",
      },
      compose = {
        -- Avoid clashing with quickmate's <leader>cc
        promote_keymap = "<leader>aP",
      },
      dashboard = {
        auto_open = false,
      },
      statusline = {
        enabled = false,
      },
    }
  end,
  config = function(_, opts)
    require("copilot_agent").setup(opts)

    if not copilot_cli_path() then
      vim.schedule(function()
        vim.notify(
          ("Missing pinned Copilot CLI (@github/copilot@%s).\nRun :Lazy build copilot-agent.nvim"):format(
            COPILOT_CLI_PIN
          ),
          vim.log.levels.WARN,
          { title = "copilot-agent" }
        )
      end)
    end
  end,
  keys = function()
    local keys = {
      {
        "<leader>aA",
        "<cmd>CopilotAgentChatToggle<cr>",
        desc = "Copilot Agent Chat",
        mode = { "n", "v" },
      },
      {
        "<leader>aD",
        "<cmd>CopilotAgentDashboard<cr>",
        desc = "Copilot Agent Dashboard",
      },
      {
        "<leader>aN",
        "<cmd>CopilotAgentNewSession<cr>",
        desc = "Copilot Agent New Session",
      },
      {
        "<leader>am",
        "<cmd>CopilotAgentModel<cr>",
        desc = "Copilot Agent Model",
      },
      {
        "<leader>a?",
        "<cmd>CopilotAgentStatus<cr>",
        desc = "Copilot Agent Status",
      },
      {
        "<leader>aP",
        "<cmd>CopilotAgentPromoteToCompose<cr>",
        desc = "Copilot Agent Promote to Compose",
      },
    }

    -- When agent is the selected chat backend, own the focus keymap.
    if env.ai_chat == "copilot-agent" then
      keys[#keys + 1] = {
        "<C-.>",
        "<cmd>CopilotAgentChatFocus<cr>",
        mode = { "n", "t", "i", "x" },
        desc = "Copilot Agent Focus",
      }
    end

    return keys
  end,
}
