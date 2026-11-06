---@type NvPluginSpec
return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  ft = { "qf" },
  cmd = { "TroubleToggle", "Trouble", "TodoTrouble" },
  keys = {
    { "<leader>ld", "<cmd>Trouble diagnostics<cr>", desc = "LSP Diagnostics" },
    {
      "<leader>lt",
      "<CMD>TodoTrouble keywords=TODO,FIX,FIXME,BUG,TEST,NOTE<CR>",
      desc = "LSP Todo/Fix/Fixme",
    },
    {
      "Q",
      function()
        local trouble = require "trouble"
        if trouble.is_open() then
          trouble.close()
          return
        end
        require("quicker").close()
      end,
      desc = "Close Trouble / quickfix",
    },
  },
  opts = {
    focus = true,
    auto_jump = false,
    auto_preview = true,
    preview = {
      type = "split",
      position = "right",
      relative = "win",
      size = 0.5,
      on_mount = function()
        vim.cmd [[Neominimap TabDisable]]
      end,
    },
    keys = {
      ["<tab>"] = "next",
      ["<s-tab>"] = "prev",
    },
  },
}
