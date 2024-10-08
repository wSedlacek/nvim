---@type NvPluginSpec
return {
  "nvim-focus/focus.nvim",
  event = "VeryLazy",
  config = function()
    require("focus").setup {
      ui = {
        signcolumn = false,
        cursorline = true,
      },
    }

    local ignore_filetypes = { "neo-tree", "NvimTree", "Outline", "qf", "trouble", "DiffviewFiles" }
    local ignore_buftypes = { "nofile", "prompt", "popup" }

    local augroup = vim.api.nvim_create_augroup("FocusDisable", {
      clear = true,
    })

    vim.api.nvim_create_autocmd({ "WinEnter", "WinNew" }, {
      group = augroup,
      callback = function(_)
        vim.schedule(function()
          if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
            vim.b.focus_disable = true
          end
        end)
      end,
      desc = "Disable focus autoresize for BufType",
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      callback = function(_)
        if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
          vim.b.focus_disable = true
        end
      end,
      desc = "Disable focus autoresize for FileType",
    })
  end,
}
