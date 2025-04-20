vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter", "tabnew" }, {
  callback = function()
    vim.t.bufs = vim.tbl_filter(function(bufnr)
      return vim.api.nvim_get_option_value("modified", { buf = bufnr })
    end, vim.t.bufs)
  end,
})
