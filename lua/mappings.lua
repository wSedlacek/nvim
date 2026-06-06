-- Save lazy-loaded plugin keys before loading NvChad base mappings
local lazy_keys_util = require "utils.lazy_keys"
local saved_keys = lazy_keys_util.save()

-- Load NvChad base mappings (may overwrite plugin keys)
require "nvchad.mappings"

lazy_keys_util.restore(saved_keys)

local map = vim.keymap.set
local env = require "env"

if vim.g.neovide then
  vim.g.neovide_scale_factor = 0.9

  map("n", "<D-=>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.25
  end, {
    desc = "Increase scale factor",
  })
  map("n", "<D-->", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.25
  end, {
    desc = "Decrease scale factor",
  })
  map("n", "<D-s>", "<cmd>w<cr>", {
    desc = "Save",
  })
  map("n", "<D-v>", '"+P', {
    desc = "Paste",
  })

  map("v", "<D-c>", '"+y', {
    desc = "Copy",
  })
  map("v", "<D-v>", '"+P', {
    desc = "Paste",
  })

  map("c", "<D-v>", "<C-r>+", {
    desc = "Paste",
  })
  map("i", "<D-v>", '<ESC>l"+Pli', {
    desc = "Paste",
  })
end

-- General
map("n", "<leader>;", "<cmd>Nvdash<cr>", {
  desc = "Return to dashboard",
})
map("n", ";", ":", {
  desc = "CMD enter command mode",
  nowait = true,
})
map("n", "J", "mzJ`z", {
  desc = "Remove line break",
})

-- Resenters screen after jumping (Note scroll down add 1 line to correct for navic)
map("n", "<C-d>", "<C-d>zz<C-y>", {
  desc = "Jump Half page down",
})
map("n", "<C-u>", "<C-u>zz", {
  desc = "Jump Half page up",
})

map("n", "n", "nzzzv", {
  desc = "Find next",
})
map("n", "N", "Nzzzv", {
  desc = "Find previous",
})
map("n", "gx", "<cmd>silent execute '!open ' . shellescape(expand('<cfile>'), 1)<cr>", {
  desc = "Open link",
})
map("n", "<leader>fr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
  desc = "Replace section",
})
map("n", "<leader>Q", "<cmd>xa<cr>", {
  desc = "Save All and Quit",
})

map("i", "<C-c>", "<Esc>", {
  desc = "Return to normal mode",
})

-- Selection
map("n", "<A-k>", ":m .-2<CR>==", {
  desc = "Move selection up",
  silent = true,
})
map("n", "<A-Up>", ":m .-2<CR>==", {
  desc = "Move selection up",
  silent = true,
})
map("n", "<A-j>", ":m .+1<CR>==", {
  desc = "Move selection down",
  silent = true,
})
map("n", "<A-Down>", ":m .+1<CR>==", {
  desc = "Move selection down",
  silent = true,
})

map("v", "J", ":m '>+1<CR>gv=gv", {
  desc = "Move selection down",
  silent = true,
})
map("v", "<A-k>", ":m '<-2<CR>gv=gv", {
  desc = "Move selection up",
  silent = true,
})
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", {
  desc = "Move selection up",
  silent = true,
})
map("v", "K", ":m '<-2<CR>gv=gv", {
  desc = "Move selection up",
  silent = true,
})
map("v", "<A-j>", ":m '>+1<CR>gv=gv", {
  desc = "Move selection down",
  silent = true,
})
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", {
  desc = "Move selection down",
  silent = true,
})

-- Version Control System
if env.vsc == "jj" then
  map("n", "<leader>gj", function()
    local function opts_to_id(id)
      for _, opts in pairs(vim.g.nvchad_terms) do
        if opts.id == id then
          return opts
        end
      end
    end

    local nvterm = require "nvchad.term"
    nvterm.runner { pos = "sp", id = "jj", cmd = "lazyjj && exit || exit" }

    local opts = opts_to_id "jj"
    if not opts then
      return
    end

    vim.api.nvim_create_autocmd("TermClose", {
      callback = function(args)
        if args.buf ~= opts.buf then
          return
        end

        vim.schedule(function()
          vim.api.nvim_buf_delete(opts.buf, {})
        end)
      end,
    })
  end, { desc = "vsc Open Version Control" })
end

-- LSP
map("n", "<leader>lf", "<cmd>EslintFixAll<cr>", {
  desc = "LSP Fix all",
})

-- Quickfix
map("n", "<C-0>", "<cmd>Cclear<cr><cmd>cclose<cr>", {
  desc = "Clear Quickfix",
})
map("n", "<C-=>", "<cmd>QNext!<cr>", {
  desc = "Previous quickfix",
})
map("n", "<C-->", "<cmd>QPrev!<cr>", {
  desc = "Next quickfix",
})
map("n", "<C-BS>", "<cmd>copen<cr><cmd>Reject<cr>", {
  desc = "Remove from Quickfix",
})

-- tabufline
map("n", "<leader>X", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, {
  desc = "Close other buffers",
})

-- Terminal

map("t", "<C-x>", "<C-\\><C-N>", { desc = "Terminal Escape terminal mode" })

-- new
map("n", "<leader>h", function()
  require("nvchad.term").new { pos = "sp" }

  -- Trigger switch back and forth to automatically resize
  -- nvim-focus/focus.nvim
  vim.cmd [[wincmd k]]
  vim.cmd [[wincmd j]]
end, { desc = "Terminal New horizontal term" })

map("n", "<leader>v", function()
  require("nvchad.term").new { pos = "vsp" }

  -- Trigger switch back and forth to automatically resize
  -- nvim-focus/focus.nvim
  vim.cmd [[wincmd h]]
  vim.cmd [[wincmd l]]
end, { desc = "Terminal New vertical window" })

-- toggle
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm", size = 1 }

  -- Trigger switch back and forth to automatically resize
  -- nvim-focus/focus.nvim
  vim.cmd [[wincmd h]]
  vim.cmd [[wincmd l]]
end, { desc = "Terminal Toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm", size = 1 }

  -- Trigger switch back and forth to automatically resize
  -- nvim-focus/focus.nvim
  vim.cmd [[wincmd k]]
  vim.cmd [[wincmd j]]
end, { desc = "Terminal New horizontal term" })

-- Menu
vim.keymap.set("n", "<C-t>", function()
  require("menu").open "default"
end, {})

vim.keymap.set("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

-- Copilot CLI
if env.ai_chat == "copilot-cli" then
  map({ "n", "t" }, "<C-.>", function()
    require("snacks").terminal.toggle("copilot", {
      win = { position = "right", width = 0.4 },
      cwd = vim.fn.getcwd(),
    })
  end, { desc = "Toggle Copilot CLI" })
end

-- Remove default keymaps
local unmap = vim.keymap.del

unmap("n", "<leader>rn")
