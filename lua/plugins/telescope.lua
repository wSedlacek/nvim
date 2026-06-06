---@type NvPluginSpec
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  keys = {
    {
      "<leader>fW",
      function()
        require("telescope.builtin").grep_string { search = vim.fn.expand "<cword>" }
      end,
      desc = "Telescope Find word under cursor",
    },
    { "<leader>fs", "<cmd>Telescope ast_grep<cr>", desc = "Telescope Find AST" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Telescope Find keymaps" },
    { "\\", "<cmd>Telescope resume<cr>", desc = "Telescope Resume last search" },
    { "<leader>gt", "<cmd>Telescope git_status<cr>", desc = "vsc status" },
    { "<leader>gC", "<cmd>Telescope git_commits<cr>", desc = "vsc commit list" },
  },
  opts = {
    extensions_list = { "themes", "terms", "fzf" },
    defaults = {
      borderchars = {
        prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
        results = { " ", " ", " ", " ", " ", " ", " ", " " },
        preview = { " ", " ", " ", " ", " ", " ", " ", " " },
      },
    },
  },
}
