---@param url string
---@return nil|string
local parse_url = function(url)
  return url:match "^.*://(.*)$"
end

vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(args)
    if args.data.err == nil then
      for _, action in ipairs(args.data.actions) do
        if action.type == "delete" then
          local path = parse_url(action.url)
          local bufnr = vim.fn.bufnr(path)
          if bufnr == -1 then
            return
          end

          vim.t.bufs = vim.tbl_filter(function(b)
            return b ~= bufnr
          end, vim.t.bufs)
          vim.cmd("bdelete " .. bufnr)
        end
      end
    end
  end,
})
