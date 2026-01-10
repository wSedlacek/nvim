---@type NvPluginSpec
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>mm", "<cmd>lua require('harpoon'):list():add()<cr>", desc = "Mark file" },
    {
      "<leader>mt",
      function()
        local conf = require("telescope.config").values
        local harpoon = require "harpoon"
        local harpoon_files = harpoon:list()
        local finder = function()
          local paths = {}
          for _, item in ipairs(harpoon_files.items) do
            table.insert(paths, item.value)
          end

          return require("telescope.finders").new_table {
            results = paths,
          }
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = finder(),
            previewer = false,
            sorter = conf.generic_sorter {},
            layout_config = {
              height = 0.4,
              width = 0.5,
              prompt_position = "top",
              preview_cutoff = 120,
            },
            attach_mappings = function(prompt_bufnr, map)
              map("i", "<C-d>", function()
                local state = require "telescope.actions.state"
                local selected_entry = state.get_selected_entry()
                local current_picker = state.get_current_picker(prompt_bufnr)

                table.remove(harpoon_files.items, selected_entry.index)
                current_picker:refresh(finder())
              end)
              return true
            end,
          })
          :find()
      end,
      desc = "Toggle UI",
    },
    { "<leader>ma", "<cmd>lua require('harpoon'):list():select(1)<cr>", desc = "Goto mark 1" },
    { "<leader>ms", "<cmd>lua require('harpoon'):list():select(2)<cr>", desc = "Goto mark 2" },
    { "<leader>md", "<cmd>lua require('harpoon'):list():select(3)<cr>", desc = "Goto mark 3" },
    { "<leader>mf", "<cmd>lua require('harpoon'):list():select(4)<cr>", desc = "Goto mark 4" },
    { "<leader>mg", "<cmd>lua require('harpoon'):list():select(5)<cr>", desc = "Goto mark 5" },
    { "<leader>mq", "<cmd>lua require('harpoon'):list():select(6)<cr>", desc = "Goto mark 6" },
    { "<leader>mw", "<cmd>lua require('harpoon'):list():select(7)<cr>", desc = "Goto mark 7" },
    { "<leader>me", "<cmd>lua require('harpoon'):list():select(8)<cr>", desc = "Goto mark 8" },
    { "<leader>mr", "<cmd>lua require('harpoon'):list():select(9)<cr>", desc = "Goto mark 9" },
    { "<leader>mn", "<cmd>lua require('harpoon'):list():next()<cr>", desc = "Next file" },
    { "<leader>mN", "<cmd>lua require('harpoon'):list():prev()<cr>", desc = "Prev file" },
  },
  config = function()
    local harpoon = require "harpoon"
    harpoon:setup()
  end,
}
