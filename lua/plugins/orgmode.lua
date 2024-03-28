--- @type NvPluginSpec
local default_notes = "~/Notes/"

local default_note_refile = default_notes .. "refile.org"
local default_note_study = default_notes .. "study.org"
local default_note_work = default_notes .. "flagship.org"

local default_note_reports = default_notes .. "reports.org"
local default_note_mgmt = default_notes .. "mgmt.org"
local default_note_journal = default_notes .. "journal.org"
local default_note_tasks = default_notes .. "todos.org"
local default_note_meetings = default_notes .. "meetings.org"
local default_note_neovim = default_notes .. "neovim.org"

return {
  "nvim-orgmode/orgmode",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" },
    { "akinsho/org-bullets.nvim", opts = {}, after = "orgmode" },
  },
  config = function()
    require("orgmode").setup_ts_grammar()
    require("orgmode").setup {
      org_agenda_files = "~/Notes/**/*",
      org_default_notes_file = default_note_refile,
      org_startup_folded = "showeverything",
      org_capture_templates = {
        t = { description = "Task", template = "* TODO %?\n %u", target = default_note_tasks },
        r = { description = "Reports", template = "** %T Observation %?", target = default_note_reports },
        m = { description = "Management Task ", template = "** TODO %T %?", target = default_note_mgmt },
        j = {
          description = "Journal",
          template = "\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?",
          target = default_note_journal,
        },
        M = { description = "Meeting Notes ", template = "** %T %?", target = default_note_meetings },
        n = { description = "Neovim Config", template = "** TODO %T %?", target = default_note_neovim },
        w = {
          description = "Work Task",
          template = "* TODO %?\n SCHEDULED: %t",
          target = default_note_work,
        },
        s = {
          description = "Study Task",
          template = "* TODO %?\n SCHEDULED: %t",
          target = default_note_study,
        },
      },
      mappings = {
        org = {
          org_return = false,
          org_cycle = "<A-Tab>",
          org_global_cycle = "<S-A-Tab>",
          org_insert_todo_heading = "<leader>a",
        },
      },
      ui = {
        menu = {
          handler = function(data)
            local options = {}
            local options_by_label = {}

            for _, item in ipairs(data.items) do
              if item.key and item.label:lower() ~= "quit" then
                table.insert(options, item.label)
                options_by_label[item.label] = item
              end
            end

            local handler = function(choice)
              if not choice then
                return
              end

              local option = options_by_label[choice]
              if option.action then
                option.action()
              end
            end

            vim.ui.select(options, {
              propmt = data.propmt,
            }, handler)
          end,
        },
      },
    }
  end,
  ft = { "org" },
  keys = {
    {
      "<leader>oc",
      function()
        require("orgmode").action "capture.prompt"
      end,
      desc = "org capture",
    },
    {
      "<leader>oa",
      function()
        require("orgmode").action "agenda.prompt"
      end,
      desc = "org agenda",
    },
    {
      "<leader>oR",
      "<cmd>e " .. default_note_refile .. "<cr>",
      desc = "org open refile",
    },
  },
}
