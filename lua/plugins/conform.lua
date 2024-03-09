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
      javascript = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      json = { "prettierd" },
      html = { { "prettierd", "prettier" } },
      scss = { { "prettierd", "prettier" } },
      css = { { "prettierd", "prettier" } },
      markdown = { "markdownlint" },
      ocaml = { "ocamlformat" },
      sql = { "pg_format" },
      swift = { "swift_format" },
      proto = { "buf" },
      yaml = { { "prettierd", "prettier" } },
    },

    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      if slow_format_filetypes[vim.bo[bufnr].filetype] then
        return
      end

      local function on_format(err)
        if err and err:match "timeout$" then
          slow_format_filetypes[vim.bo[bufnr].filetype] = true
        end
      end

      return { timeout_ms = 500, lsp_fallback = true }, on_format
    end,

    format_after_save = function(bufnr)
      if not slow_format_filetypes[vim.bo[bufnr].filetype] then
        return
      end

      return { lsp_fallback = true }
    end,
  },
}
