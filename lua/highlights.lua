-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = { italic = true },
  Boolean = { italic = true },
  Conditional = { italic = true, bold = true },
  Repeat = { italic = true },
  ["@keyword.return"] = { italic = true },
  ["@keyword.operator"] = { italic = true },
  ["@keyword.function"] = { italic = true },
  ["@exception"] = { italic = true },
  ["@include"] = { italic = true },
  ["@repeat"] = { italic = true },

  TelescopePromptNormal = { blend = 100 },
}

---@type HLTable
M.add = {
  -- Flat Floating
  NormalFloat = { fg = "white", bg = "darker_black", blend = 0 },
  FloatBorder = { fg = "darker_black", bg = "darker_black", blend = 5 },

  -- Nvim Tree
  NvimTreeOpenedFolderName = { fg = "green", bold = true },

  -- Bqf
  BqfPreviewFloat = { link = "NormalFloat" },
  BqfPreviewBorder = { link = "FloatBorder" },
  BqfPreviewTitle = { link = "TelescopePreviewTitle" },

  -- Diagnostics
  DiagnosticVirtualTextHint = { link = "Comment" },
  DiagnosticVirtualTextInfo = { link = "Comment" },
  DiagnosticVirtualTextWarn = { link = "Comment" },
  DiagnosticVirtualTextError = { link = "Comment" },

  -- Leap
  LeapBackdrop = { link = "Comment" },
  LeapMatch = { fg = "white", bold = true, nocombine = true },
  LeapLabelPrimary = { fg = "red", bold = true, nocombine = true },
  LeapLabelSecondary = { fg = "blue", bold = true, nocombine = true },

  -- Messages
  NoiceLspProgressTitle = { link = "Normal" },

  -- Command Prompt
  NoiceCmdlineIcon = { fg = "green" },
  NoiceCmdlinePopup = { bg = "darker_black", blend = 47 },
}

return M
