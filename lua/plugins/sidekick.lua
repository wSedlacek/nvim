local env = require "env"

---@type NvPluginSpec
return {
  "folke/sidekick.nvim",
  enabled = env.sidekick,
  event = env.sidekick_nes and "VeryLazy" or nil,
  cmd = { "Sidekick" },
  dependencies = {
    { "folke/snacks.nvim", optional = true },
    { "nvim-treesitter/nvim-treesitter-textobjects", optional = true },
  },
  opts = function()
    local mux_enabled = vim.fn.executable "tmux" == 1 or vim.fn.executable "zellij" == 1

    return {
      nes = {
        enabled = function(buf)
          if not env.sidekick_nes then
            return false
          end
          local b = vim.b[buf]
          return vim.g.sidekick_nes ~= false and (not b or b.sidekick_nes ~= false)
        end,
        debounce = 100,
        diff = {
          inline = "words",
          show = "always",
        },
        signs = true,
        jumplist = true,
      },
      cli = {
        watch = true,
        win = {
          layout = "right",
          split = {
            width = 0.4,
          },
        },
        mux = {
          backend = vim.env.ZELLIJ and "zellij" or "tmux",
          enabled = mux_enabled,
          create = "terminal",
        },
        picker = "snacks",
        tools = {
          aider = {},
          amazon_q = {},
          claude = {},
          codex = {},
          copilot = {},
          crush = {},
          cursor = {},
          gemini = {},
          grok = {},
          opencode = {},
          pi = {},
          qwen = {},
        },
      },
      copilot = {
        status = {
          enabled = env.sidekick_nes,
          level = vim.log.levels.WARN,
        },
      },
    }
  end,
  keys = function()
    local tool = env.ai_chat_tool
    local keys = {}

    local function chat(fn)
      return function()
        if not env.sidekick_chat then
          vim.notify("NVIM_AI_CHAT is not a Sidekick CLI tool", vim.log.levels.WARN, { title = "sidekick" })
          return
        end
        fn()
      end
    end

    if env.sidekick_nes then
      keys[#keys + 1] = {
        "<tab>",
        function()
          if require("sidekick").nes_jump_or_apply() then
            return
          end
          if vim.lsp.inline_completion and vim.lsp.inline_completion.get() then
            return
          end
          return "<Tab>"
        end,
        mode = { "n", "i" },
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      }
      keys[#keys + 1] = {
        "<leader>an",
        function() require("sidekick.nes").toggle() end,
        desc = "Toggle Sidekick NES",
      }
    end

    if env.sidekick_chat then
      keys[#keys + 1] = {
        "<C-.>",
        chat(function()
          require("sidekick.cli").focus { name = tool }
        end),
        mode = { "n", "t", "i", "x" },
        desc = "Sidekick Focus",
      }
      keys[#keys + 1] = {
        "<leader>aa",
        chat(function()
          require("sidekick.cli").toggle { name = tool, focus = true }
        end),
        desc = "Sidekick Toggle CLI",
      }
      keys[#keys + 1] = {
        "<leader>as",
        chat(function()
          require("sidekick.cli").select { filter = { installed = true } }
        end),
        desc = "Sidekick Select CLI",
      }
      keys[#keys + 1] = {
        "<leader>ad",
        chat(function() require("sidekick.cli").close() end),
        desc = "Sidekick Detach CLI",
      }
      keys[#keys + 1] = {
        "<leader>at",
        chat(function()
          require("sidekick.cli").send { msg = "{this}", name = tool }
        end),
        mode = { "n", "x" },
        desc = "Sidekick Send This",
      }
      keys[#keys + 1] = {
        "<leader>af",
        chat(function()
          require("sidekick.cli").send { msg = "{file}", name = tool }
        end),
        desc = "Sidekick Send File",
      }
      keys[#keys + 1] = {
        "<leader>av",
        chat(function()
          require("sidekick.cli").send { msg = "{selection}", name = tool }
        end),
        mode = { "x" },
        desc = "Sidekick Send Selection",
      }
      keys[#keys + 1] = {
        "<leader>ap",
        chat(function()
          require("sidekick.cli").prompt { name = tool }
        end),
        mode = { "n", "x" },
        desc = "Sidekick Prompt",
      }
      keys[#keys + 1] = {
        "<leader>ac",
        chat(function()
          require("sidekick.cli").toggle { name = tool, focus = true }
        end),
        desc = "Sidekick Toggle " .. tool,
      }
    end

    return keys
  end,
  config = function(_, opts)
    require("sidekick").setup(opts)

    if not env.sidekick_nes then
      return
    end

    -- Copilot LSP powers Sidekick NES + native inline completions
    if vim.fn.executable "copilot-language-server" == 0 then
      vim.notify(
        "copilot-language-server not found. Install it (npm i -g @github/copilot-language-server) then :LspCopilotSignIn",
        vim.log.levels.WARN,
        { title = "sidekick" }
      )
    end

    vim.lsp.enable "copilot"

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserCopilotInline", { clear = true }),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or client.name ~= "copilot" then
          return
        end

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, args.buf) then
          vim.lsp.inline_completion.enable(true, { bufnr = args.buf })

          vim.keymap.set("i", "<C-cr>", function()
            if not vim.lsp.inline_completion.get() then
              return "<C-cr>"
            end
          end, { expr = true, buffer = args.buf, desc = "Accept Copilot inline" })

          vim.keymap.set("i", "<C-j>", function()
            vim.lsp.inline_completion.select()
          end, { buffer = args.buf, desc = "Next Copilot inline" })

          vim.keymap.set("i", "<C-]>", function()
            -- dismiss by disabling briefly then re-enabling on next attach/update
            vim.lsp.inline_completion.enable(false, { bufnr = args.buf })
            vim.defer_fn(function()
              if vim.api.nvim_buf_is_valid(args.buf) then
                vim.lsp.inline_completion.enable(true, { bufnr = args.buf })
              end
            end, 50)
          end, { buffer = args.buf, desc = "Dismiss Copilot inline" })
        end
      end,
    })
  end,
}
