-- Statuscolumn was added in 0.9.
if vim.version.major == 0 and vim.version.minor < 9 then
  return
end

-- With sepaartor.
vim.opt.numberwidth = 5
vim.opt.statuscolumn = "%= %{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum) : ''}%=│%s"

local augroup = vim.api.nvim_create_augroup("numbertoggle", {})

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
  pattern = "*",
  group = augroup,
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
      vim.opt.numberwidth = 5
      vim.opt.relativenumber = true
      vim.opt.statuscolumn = "%= %{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum) : ''}%=│%s"
    end
  end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
  pattern = "*",
  group = augroup,
  callback = function()
    if vim.o.nu then
      vim.opt.numberwidth = 5
      vim.opt.relativenumber = false
      vim.opt.statuscolumn = "%= %l%=│%s"
      vim.cmd "redraw"
    end
  end,
})

local blacklistedFormats = {
  "aerial",
  "minimap",
  "dirvish",
  "Harpoon",
  "fugitive",
  "alpha",
  "NvimTree",
  "lazy",
  "neogitstatus",
  "Trouble",
  "lir",
  "Outline",
  "spectre_panel",
  "toggleterm",
  "DressingSelect",
  "TelescopePrompt",
  "nvdash",
  "terminal",
  "nvcheatsheet",
  "leetcode.nvim",
  "fish",
  "",
}

local id = vim.api.nvim_create_augroup("StatusCol", {})
vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "WinEnter" }, {
  group = id,
  callback = function()
    local fileType = vim.api.nvim_buf_get_option(0, "ft")

    if vim.tbl_contains(blacklistedFormats, fileType) then
      vim.opt_local.statuscolumn = ""
      vim.opt_local.number = false
    end
  end,
})
