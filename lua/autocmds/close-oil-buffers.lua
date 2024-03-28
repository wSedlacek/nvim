---@param url string
---@return nil|string
vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(args)
    local parse_url = function(url)
      return url:match "^.*://(.*)$"
    end

    if args.data.err then
      return
    end

    for _, action in ipairs(args.data.actions) do
      if action.type == "delete" and action.entry_type == "file" then
        local path = parse_url(action.url)
        local bufnr = vim.fn.bufnr(path)
        if bufnr == -1 then
          return
        end

        local winnr = vim.fn.win_findbuf(bufnr)[1]
        if not winnr then
          return
        end

        vim.fn.win_execute(winnr, "bfirst | bw " .. bufnr)
      end
    end
  end,
})
