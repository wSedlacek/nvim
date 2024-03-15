---@type NvPluginSpec
return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  ft = { "qf" },
  cmd = { "TroubleToggle", "Trouble", "TodoTroube" },
  opts = {},
  config = function(_, opts)
    require("trouble").setup(opts)

    -- hijack other windows with trouble https://github.com/folke/trouble.nvim/issues/70#issuecomment-1528094026
    local function use_trouble()
      local trouble = require "trouble"
      -- Check whether we deal with a quickfix or location list buffer, close the window and open the
      -- corresponding Trouble window instead.
      if vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0 then
        vim.schedule(function()
          vim.cmd.lclose()
          trouble.open "loclist"
        end)
      else
        vim.schedule(function()
          vim.cmd.cclose()
          trouble.open "quickfix"
        end)
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "qf" },
      callback = use_trouble,
    })
  end,
}
