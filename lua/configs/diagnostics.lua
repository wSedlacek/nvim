local function best_diagnostic(diagnostics)
  if vim.tbl_isempty(diagnostics) then
    return
  end

  local best = nil
  local line_diagnostics = {}
  local line_nr = vim.api.nvim_win_get_cursor(0)[1] - 1

  for k, v in pairs(diagnostics) do
    if v.lnum == line_nr then
      line_diagnostics[k] = v
    end
  end

  for _, diagnostic in ipairs(line_diagnostics) do
    if best == nil then
      best = diagnostic
    elseif diagnostic.severity < best.severity then
      best = diagnostic
    end
  end

  return best
end

local function current_line_diagnostics()
  local bufnr = 0
  local line_nr = vim.api.nvim_win_get_cursor(0)[1] - 1
  local opts = { ["lnum"] = line_nr }

  return vim.diagnostic.get(bufnr, opts)
end

local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}

local virt_handler = vim.diagnostic.handlers.virtual_text
local ns = vim.api.nvim_create_namespace "current_line_virt"
local severity = vim.diagnostic.severity
local virt_options = {
  prefix = "",
  format = function(diagnostic)
    local message = vim.split(diagnostic.message, "\n")[1]

    if diagnostic.severity == severity.ERROR then
      return signs.Error .. message
    elseif diagnostic.severity == severity.INFO then
      return signs.Info .. message
    elseif diagnostic.severity == severity.WARN then
      return signs.Warn .. message
    elseif diagnostic.severity == severity.HINT then
      return signs.Hint .. message
    else
      return message
    end
  end,
}

vim.diagnostic.handlers.current_line_virt = {
  show = function(_, bufnr, diagnostics, _)
    local diagnostic = best_diagnostic(diagnostics)
    if not diagnostic then
      return
    end

    local filtered_diagnostics = { diagnostic }

    virt_handler.hide(ns, vim.api.nvim_get_current_buf())
    pcall(virt_handler.show, ns, bufnr, filtered_diagnostics, { virtual_text = virt_options })
  end,
  hide = function(_, bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    virt_handler.hide(ns, bufnr)
  end,
}

vim.diagnostic.config {
  float = { source = "always" },
  signs = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = false,
  severity_sort = true,
  current_line_virt = true,
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.api.nvim_create_augroup("lsp_diagnostic_current_line", {
  clear = true,
})

vim.api.nvim_clear_autocmds {
  group = "lsp_diagnostic_current_line",
}

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = "lsp_diagnostic_current_line",
  callback = function()
    vim.diagnostic.handlers.current_line_virt.show(nil, 0, current_line_diagnostics(), nil)
  end,
})

local line = nil
vim.api.nvim_create_autocmd("CursorMoved", {
  group = "lsp_diagnostic_current_line",
  callback = function()
    local next_line = vim.api.nvim_win_get_cursor(0)[1] - 1

    if line ~= next_line then
      line = next_line
      vim.diagnostic.handlers.current_line_virt.hide(nil, nil)
    end
  end,
})
