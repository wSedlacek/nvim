---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "highlights"
local fortune = require "fortune"

M.ui = {
  theme = "oxocarbon",

  hl_override = highlights.override,
  hl_add = highlights.add,

  lsp = {
    semantic_tokens = false,
    signature = true,
  },

  nvdash = {
    load_on_startup = true,
    header = fortune.get_fortune(48),
    buttons = {
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "  Find Project", "Spc f p", "Telescope projects" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m t", "Telescope harpoon marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },

  integrations = {
    "blankline",
    "notify",
    "navic",
    "trouble",
    "mason",
    "codeactionmenu",
  },

  telescope = { style = "borderless" },
  cheatsheet = { theme = "grid" },
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

return M
