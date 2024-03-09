---@type NvPluginSpec
return {
  "nvim-neotest/neotest",
  enabled = false,
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "rouge8/neotest-rust",
    "haydenmeade/neotest-jest",
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
          dap_adapter = "lldb",
        },
      },
    }
  end,
}
