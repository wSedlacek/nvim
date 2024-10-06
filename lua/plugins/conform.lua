---@type NvPluginSpec
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

local slow_format_filetypes = { "typescript", "javascript", "swift" }
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt" },
      terraform = { "terraform_fmt" },
      javascript = { "biome", "prettierd", "prettier", stop_after_first = true },

      javascriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
      typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
      json = { "biome", "prettierd", "prettier", stop_after_first = true },
      jsonc = { "biome", "prettierd", "prettier", stop_after_first = true },

      html = { "prettierd", "prettier", stop_after_first = true },
      scss = { "biome", "prettierd", "prettier", stop_after_first = true },
      css = { "biome", "prettierd", "prettier", stop_after_first = true },
      markdown = { "markdownlint" },
      sql = { "pg_format" },
      swift = { "swift_format" },
      proto = { "buf" },
      yaml = { "prettierd", "prettier", stop_after_first = true },
    },

    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      return { timeout_ms = 500 }
    end,

    format_after_save = function(bufnr)
      if not slow_format_filetypes[vim.bo[bufnr].filetype] then
        return
      end

      return { lsp_fallback = true }
    end,
  },
}
