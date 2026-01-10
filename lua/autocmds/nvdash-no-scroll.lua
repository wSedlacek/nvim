-- Disable scrolling in nvdash using WinScrolled event
vim.api.nvim_create_autocmd("FileType", {
  pattern = "nvdash",
  callback = function(args)
    local bufnr = args.buf
    local saved_view = nil

    -- Save the initial view
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(bufnr) then
        saved_view = vim.fn.winsaveview()
      end
    end)

    -- Create autocmd to prevent scrolling
    local group = vim.api.nvim_create_augroup("nvdash_no_scroll_" .. bufnr, { clear = true })
    vim.api.nvim_create_autocmd("WinScrolled", {
      group = group,
      buffer = bufnr,
      callback = function()
        if saved_view and vim.bo[bufnr].filetype == "nvdash" then
          vim.fn.winrestview(saved_view)
        end
      end,
    })

    -- Clean up when buffer is closed
    vim.api.nvim_create_autocmd("BufUnload", {
      group = group,
      buffer = bufnr,
      callback = function()
        vim.api.nvim_del_augroup_by_name("nvdash_no_scroll_" .. bufnr)
      end,
    })
  end,
})
