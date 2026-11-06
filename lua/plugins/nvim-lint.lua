---@type NvPluginSpec
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile", "BufWritePost" },
  config = function()
    local lint = require "lint"

    -- Match previous none-ls behavior: treat SwiftLint findings as hints.
    lint.linters.swiftlint = require("lint.util").wrap(lint.linters.swiftlint, function(diagnostic)
      diagnostic.severity = vim.diagnostic.severity.HINT
      return diagnostic
    end)

    lint.linters_by_ft = {
      dockerfile = { "hadolint" },
      swift = { "swiftlint" },
      markdown = { "markdownlint" },
    }

    local group = vim.api.nvim_create_augroup("UserNvimLint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = group,
      callback = function()
        -- Debounce a bit on InsertLeave to avoid racing the user.
        if vim.bo.modifiable then
          lint.try_lint()
        end
      end,
    })
  end,
  keys = {
    {
      "<leader>ll",
      function()
        require("lint").try_lint()
      end,
      desc = "Lint file",
    },
  },
}
