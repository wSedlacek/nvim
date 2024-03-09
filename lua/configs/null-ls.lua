local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {
  -- b.diagnostics.stylelint.with {
  --   filetypes = { "scss", "less", "css", "sass" },
  --   args = { "--fix", "--stdin" },
  --   condition = function(utils)
  --     return utils.root_has_file { ".stylelintrc.json", ".stylelintrc.js" }
  --   end,
  -- },

  b.diagnostics.terraform_validate,
  b.diagnostics.hadolint,
  b.diagnostics.swiftlint.with {
    diagnostics_postprocess = function(diagnostics)
      diagnostics.severity = vim.diagnostic.severity.HINT
    end,
  },
}

null_ls.setup {
  debug = false,
  sources = sources,
}
