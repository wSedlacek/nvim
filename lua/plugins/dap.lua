---@type NvPluginSpec
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "igorlfs/nvim-dap-view",
      opts = {
        auto_toggle = true,
        winbar = {
          controls = {
            enabled = true,
            position = "right",
          },
        },
        windows = {
          size = 0.25,
          position = "below",
          terminal = {
            position = "right",
            size = 0.4,
          },
        },
        -- Neovim 0.12+: show variable values inline while debugging
        virtual_text = {
          enabled = true,
          position = "inline",
        },
      },
      keys = {
        {
          "<leader>dt",
          function()
            require("dap-view").toggle()
          end,
          desc = "DAP Toggle UI",
        },
        {
          "<leader>de",
          function()
            require("dap-view").hover()
          end,
          mode = { "n", "v" },
          desc = "DAP Hover / Eval",
        },
        {
          "<leader>dw",
          "<cmd>DapViewWatch<cr>",
          mode = { "n", "v" },
          desc = "DAP Watch Expression",
        },
      },
    },
    "nvim-neotest/nvim-nio",
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "williamboman/mason.nvim",
      opts = {
        ensure_installed = { "codelldb", "js" },
        handlers = {},
      },
    },
  },
  keys = {
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "DAP Toggle Breakpoint",
    },
    {
      "<leader>dB",
      function()
        require("dap").set_breakpoint(vim.fn.input "Condition: ")
      end,
      desc = "DAP Conditional Breakpoint",
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "DAP Continue",
    },
    {
      "<leader>ds",
      function()
        require("dap").step_over()
      end,
      desc = "DAP Step Over",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "DAP Step Into",
    },
    {
      "<leader>do",
      function()
        require("dap").step_out()
      end,
      desc = "DAP Step Out",
    },
    {
      "<leader>dl",
      function()
        require("dap").run_last()
      end,
      desc = "DAP Run Last",
    },
    {
      "<leader>dx",
      function()
        require("dap").terminate()
      end,
      desc = "DAP Terminate",
    },
  },
  config = function()
    local dap = require "dap"

    -- JS/TS via vscode-js-debug (mason installs as 'js')
    local js_debug_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter"

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { js_debug_path .. "/js-debug/src/dapDebugServer.js", "${port}" },
      },
    }

    for _, lang in ipairs { "javascript", "typescript", "javascriptreact", "typescriptreact" } do
      dap.configurations[lang] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Node",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          outFiles = { "${workspaceFolder}/**/dist/**/*.js", "!**/node_modules/**" },
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to Process",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Jest Test",
          runtimeExecutable = "node",
          runtimeArgs = {
            "${workspaceFolder}/node_modules/.bin/jest",
            "--runInBand",
          },
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          sourceMaps = true,
        },
      }
    end
  end,
}
