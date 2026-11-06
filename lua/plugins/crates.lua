---@type NvPluginSpec
return {
  "saecki/crates.nvim",
  event = { "BufRead Cargo.toml" },
  opts = {
    completion = {
      crates = {
        enabled = true,
        max_results = 8,
        min_chars = 3,
      },
    },
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    },
  },
  keys = {
    {
      "<leader>cu",
      function()
        require("crates").upgrade_crate()
      end,
      ft = "toml",
      desc = "Crates upgrade",
    },
    {
      "<leader>cU",
      function()
        require("crates").upgrade_all_crates()
      end,
      ft = "toml",
      desc = "Crates upgrade all",
    },
    {
      "<leader>cv",
      function()
        require("crates").show_versions_popup()
      end,
      ft = "toml",
      desc = "Crates versions",
    },
    {
      "<leader>cF",
      function()
        require("crates").show_features_popup()
      end,
      ft = "toml",
      desc = "Crates features",
    },
  },
}
