---@type NvPluginSpec
return {
  "vuki656/package-info.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  event = { "BufRead package.json" },
  opts = {
    hide_up_to_date = true,
    package_manager = "npm",
  },
  keys = {
    {
      "<leader>ps",
      function()
        require("package-info").show { force = true }
      end,
      desc = "Package info show",
    },
    {
      "<leader>ph",
      function()
        require("package-info").hide()
      end,
      desc = "Package info hide",
    },
    {
      "<leader>pu",
      function()
        require("package-info").update()
      end,
      desc = "Package info update",
    },
    {
      "<leader>pD",
      function()
        require("package-info").delete()
      end,
      desc = "Package info delete",
    },
    {
      "<leader>pI",
      function()
        require("package-info").install()
      end,
      desc = "Package info install",
    },
    {
      "<leader>pv",
      function()
        require("package-info").change_version()
      end,
      desc = "Package info change version",
    },
  },
}
