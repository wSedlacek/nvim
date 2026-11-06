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
    -- Leading spacer clears macOS traffic lights when Neovide uses a transparent frame.
    order = { "windowControls", "treeOffset", "buffers", "harpoon", "tabs" },
    modules = {
      windowControls = function()
        if not vim.g.neovide then
          return ""
        end
        -- ~traffic-light cluster width at IosevkaTerm h16
        return "%#TbFill#" .. string.rep(" ", 8)
      end,
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
      "sidekick",
      "%=",
      "diagnostics",
      "cwd",
      "cursor",
    },
    modules = {
      noice = function()
        -- Don't require noice from the statusline — that forces a Lazy load
        -- mid-redraw in Neovide and blows up with E565 / hit-enter prompts.
        if package.loaded["noice"] == nil then
          return ""
        end
        local ok_cfg, cfg = pcall(require, "noice.config")
        if not ok_cfg or not cfg.is_running() then
          return ""
        end
        local ok, status = pcall(function()
          return require("noice").api.status.mode.get()
        end)
        if ok and status then
          return "%#NoiceVirtualText#" .. status
        end
        return ""
      end,
      sidekick = function()
        local ok, status = pcall(require, "sidekick.status")
        if not ok then
          return ""
        end

        local parts = {}
        local nes = status.get()
        if nes then
          local hl = nes.kind == "Error" and "DiagnosticError" or nes.busy and "DiagnosticWarn" or "Special"
          parts[#parts + 1] = "%#" .. hl .. "# "
        end

        local cli = status.cli()
        if cli and #cli > 0 then
          parts[#parts + 1] = "%#Special#" .. (#cli > 1 and (" " .. #cli) or "")
        end

        if #parts == 0 then
          return ""
        end
        return table.concat(parts, " ") .. " "
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
  theme = "gatekeeper",
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
  header = fortune.get_fortune(44, 2, 2),
  buttons = {
    { txt = " ", hl = "NvDashHidden", no_gap = true, rep = true },
    {
      txt = "   Find File",
      keys = "Spc f f ",
      cmd = "lua require('fff').find_files()",
      hl = "NvDashButtons",
    },
    { txt = "   Find Project", keys = "Spc f p ", cmd = "Telescope projects", hl = "NvDashButtons" },
    { txt = " 󰈚  Recent Files", keys = "Spc f o ", cmd = "Telescope oldfiles", hl = "NvDashButtons" },
    {
      txt = " 󰈭  Find Word",
      keys = "Spc f w ",
      cmd = "lua require('fff').live_grep()",
      hl = "NvDashButtons",
    },
    { txt = "   Bookmarks", keys = "Spc m t ", cmd = "Telescope harpoon marks", hl = "NvDashButtons" },
    { txt = "   Themes", keys = "Spc t h ", cmd = "Telescope themes", hl = "NvDashButtons" },
    { txt = "   Mappings", keys = "Spc c h ", cmd = "NvCheatsheet", hl = "NvDashButtons" },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "   Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
    },
  },
}

return M
