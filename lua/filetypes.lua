-- SQL
vim.g.omni_sql_no_default_maps = 1

local vim_filetype_group = vim.api.nvim_create_augroup("file_type_override", { clear = true })

-- vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
--   pattern = "*.component.html",
--   command = "set filetype=angular",
-- })

vim.api.nvim_create_autocmd({ "bufread", "bufenter" }, {
  group = vim_filetype_group,
  pattern = "*.leaf",
  command = "set filetype=html",
})

vim.api.nvim_create_autocmd({ "bufread", "bufenter" }, {
  group = vim_filetype_group,
  pattern = "*/templates/*.{yaml,yml},*/templates/*.tpl,*.gotmpl,helmfile*.{yaml,yml}",
  command = "set filetype=helm",
})
