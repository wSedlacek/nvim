---@type NvPluginSpec
return {
  enabled = false,
  "nvim-neotest/neotest",
  event = "VeryLazy",
  keys = {
    {
      "<leader>ct",
      function() require("neotest").run.run() end,
      desc = "Run nearest test",
    },
    {
      "<leader>cf",
      function() require("neotest").run.run(vim.fn.expand "%") end,
      desc = "Run file tests",
    },
    {
      "<leader>cT",
      function() require("neotest").run.run(vim.fn.getcwd()) end,
      desc = "Run all tests",
    },
    {
      "<leader>cs",
      function() require("neotest").summary.toggle() end,
      desc = "Toggle test summary",
    },
    {
      "<leader>co",
      function() require("neotest").output.open { enter = true, auto_close = true } end,
      desc = "Show test output",
    },
    {
      "<leader>cO",
      function() require("neotest").output_panel.toggle() end,
      desc = "Toggle output panel",
    },
    {
      "<leader>cw",
      function() require("neotest").watch.toggle(vim.fn.expand "%") end,
      desc = "Toggle test watch",
    },
    {
      "<leader>cS",
      function() require("neotest").run.stop() end,
      desc = "Stop tests",
    },
    {
      "<leader>cd",
      function() require("neotest").run.run { strategy = "dap" } end,
      desc = "Debug nearest test",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "rouge8/neotest-rust",
    "haydenmeade/neotest-jest",
    "marilari88/neotest-vitest",
    "mmllr/neotest-swift-testing",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local function find_config(filename)
      local dir = vim.fn.expand "%:p:h"
      local found = vim.fn.findfile(filename, dir .. ";")
      if found ~= "" then
        return vim.fn.fnamemodify(found, ":p")
      end
    end

    local function config_cwd(filename)
      local cfg = find_config(filename)
      if cfg then return vim.fn.fnamemodify(cfg, ":h") end
      return vim.fn.getcwd()
    end

    require("neotest").setup {
      adapters = {
        require "neotest-jest" {
          jestConfigFile = function()
            return find_config "jest.config.ts"
              or find_config "jest.config.js"
              or (vim.fn.getcwd() .. "/jest.config.ts")
          end,
          cwd = function()
            return config_cwd "jest.config.ts"
              or config_cwd "jest.config.js"
              or vim.fn.getcwd()
          end,
        },
        require "neotest-vitest" {
          vitestConfigFile = function()
            return find_config "vitest.config.ts"
              or find_config "vitest.config.js"
              or find_config "vite.config.ts"
              or find_config "vite.config.js"
          end,
          cwd = function()
            return config_cwd "vitest.config.ts"
              or config_cwd "vitest.config.js"
              or config_cwd "vite.config.ts"
              or config_cwd "vite.config.js"
              or vim.fn.getcwd()
          end,
        },
        require "neotest-swift-testing",
        require "neotest-rust" {
          args = { "--no-capture" },
          dap_adapter = "codelldb",
        },
      },
      output = {
        open_on_run = "short",
      },
      output_panel = {
        enabled = true,
      },
      quickfix = {
        open = false,
      },
      status = {
        enabled = true,
        signs = true,
        virtual_text = true,
      },
    }
  end,
}
