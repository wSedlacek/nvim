--- @type NvPluginSpec
return {
  event = "VeryLazy",
  "folke/snacks.nvim",
  priority = 1000,
  keys = {
    -- Zen mode
    {
      "<leader>0",
      function()
        require("snacks").zen()
      end,
      desc = "Zen Mode",
    },
    -- Git browse
    {
      "<leader>gl",
      function()
        require("snacks").gitbrowse.open()
      end,
      desc = "vsc Open in GitHub",
      mode = { "n", "v" },
    },
    -- GitHub PRs
    {
      "<leader>gP",
      function()
        require("snacks").picker.gh_pr()
      end,
      desc = "vsc pr list (open)",
    },
    {
      "<leader>gp",
      function()
        require("snacks").picker.gh_pr { state = "all" }
      end,
      desc = "vsc pr list (all)",
    },
    {
      "<leader>gN",
      function()
        require("nvchad.term").runner { pos = "float", id = "gh", cmd = "gh pr create" }
      end,
      desc = "vsc pr create",
    },
    -- GitHub Issues
    {
      "<leader>gI",
      function()
        require("snacks").picker.gh_issue()
      end,
      desc = "vsc issue list (open)",
    },
    {
      "<leader>gi",
      function()
        require("snacks").picker.gh_issue { state = "all" }
      end,
      desc = "vsc issue list (all)",
    },
  },
  opts = {
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    git = { enabled = false },
    gitbrowse = { enabled = true },
    gh = {
      enabled = true,
      keys = {
        select = { "<cr>", "gh_actions", desc = "Select Action" },
        edit = { "i", "gh_edit", desc = "Edit" },
        comment = { "a", "gh_comment", desc = "Add Comment" },
        close = { "c", "gh_close", desc = "Close" },
        reopen = { "o", "gh_reopen", desc = "Reopen" },
      },
      wo = {
        wrap = true,
        breakindent = true,
        foldmethod = "expr",
        conceallevel = 2,
      },
      diff = {
        min = 4,
        wrap = 80,
      },
      scratch = {
        height = 15,
      },
    },
    image = { enabled = false },
    indent = { enabled = true, only_current = true },
    input = { enabled = true },
    lazygit = { enabled = false },
    notify = { enabled = false },
    notifier = { enabled = false },
    picker = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    scope = { enabled = true },
    scratch = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    terminal = { enabled = false },
    words = { enabled = true },
    zen = { enabled = true },
  },
  init = function()
    local Snacks = require "snacks"
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        if event.data.actions.type == "move" then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
      end,
    })
  end,
}
