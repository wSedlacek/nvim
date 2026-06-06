---@type NvPluginSpec
return {
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
    "nvim-neotest/nvim-nio",
  },
  config = function()
    require("neotest").setup {
      adapters = {
        require "neotest-jest" {
          jestConfigFile = function()
            local file = vim.fn.expand "%:p"
            if string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
            end
            if string.find(file, "/libs/") then
              return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
            end
            return vim.fn.getcwd() .. "/jest.config.ts"
          end,
          cwd = function()
            local file = vim.fn.expand "%:p"
            if string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src")
            end
            if string.find(file, "/libs/") then
              return string.match(file, "(.-/[^/]+/)src")
            end
            return vim.fn.getcwd()
          end,
        },
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
