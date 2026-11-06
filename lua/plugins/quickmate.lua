---@type NvPluginSpec
return {
  "Aietes/quickmate.nvim",
  cmd = { "Check", "CheckScript", "CheckPreset" },
  opts = {
    open_quickfix = "on_items",
    -- Prefer Trouble when available; falls back to quickfix (+ quicker.nvim)
    quickfix_view = "trouble",
    package_manager_priority = { "bun", "pnpm", "npm", "yarn" },
  },
  keys = {
    {
      "<leader>cc",
      function()
        require("quickmate").run_script "check"
      end,
      desc = "Check project (package.json check)",
    },
    {
      "<leader>ce",
      function()
        require("quickmate").run_preset "eslint"
      end,
      desc = "Check ESLint (project)",
    },
    {
      "<leader>cY",
      function()
        require("quickmate").run_preset "tsc"
      end,
      desc = "Check TypeScript (tsc)",
    },
    {
      "<leader>cr",
      function()
        require("quickmate").run_preset "rust"
      end,
      desc = "Check Rust (cargo check)",
    },
    {
      "<leader>cR",
      function()
        require("quickmate").run_preset "clippy"
      end,
      desc = "Check Clippy",
    },
    {
      "<leader>cP",
      function()
        vim.ui.select({
          "eslint",
          "oxlint",
          "tsc",
          "nuxt",
          "rust",
          "clippy",
          "lua",
          "selene",
          "luacheck",
        }, { prompt = "Quickmate preset" }, function(choice)
          if choice then
            require("quickmate").run_preset(choice)
          end
        end)
      end,
      desc = "Check preset picker",
    },
  },
}
