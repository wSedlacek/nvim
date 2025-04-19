---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "highlights"
local fortune = require "fortune"

M.ui = {
  telescope = { style = "borderless" },
  cmp = {
    style = "atom_colored",
    icons = true,
    lspkind_text = false,
    selected_item_bg = "simple",
  },
  tabufline = {
    order = { "treeOffset", "buffers", "harpoon", "tabs" },
    modules = {
      harpoon = function()
        local Harpoonline = require "harpoonline"
        Harpoonline.setup {
          icon = "",
        }

        local success, line = pcall(Harpoonline.format)
        if not success then
          return ""
        end

        return "%#TbFill#" .. line .. " "
      end,
    },
  },

  statusline = {
    theme = "minimal",
    separator_style = "round",
    order = {
      "mode",
      "git",
      "%=",
      "lsp_msg",
      "noice",
      "%=",
      "diagnostics",
      "cwd",
      "cursor",
    },
    modules = {
      noice = function()
        local status = require("noice").api.status.mode.get()
        if status then
          return "%#NoiceVirtualText#" .. status
        end

        return "%##"
      end,
    },
  },
}

M.lsp = {
  semantic_tokens = false,
  signature = true,
}

M.cheatsheet = {
  theme = "grid",
}

M.base46 = {
  theme = "oxocarbon",
  hl_override = highlights.override,
  hl_add = highlights.add,

  integrations = {
    "blankline",
    "notify",
    "navic",
    "trouble",
    "codeactionmenu",
    "neogit",
    "defaults",
  },
}

M.nvdash = {
  load_on_startup = true,
  header = fortune.get_fortune(48),
  buttons = {
    { txt = " ", hl = "NvDashHidden", no_gap = true, rep = true },
    { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
    { txt = "  Find Project", keys = "Spc f p", cmd = "Telescope projects" },
    { txt = "󰈚  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "Spc f w", cmd = "Telescope live_grep" },
    { txt = "  Bookmarks", keys = "Spc m t", cmd = "Telescope harpoon marks" },
    { txt = "  Themes", keys = "Spc t h", cmd = "Telescope themes" },
    { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
    },
  },
}

return M
