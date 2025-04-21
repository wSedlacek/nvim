require "nvchad.mappings"

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
map("n", "<leader>fm", function()
  require("conform").format()
end, {
  desc = "File Format with conform",
})

map("n", "<leader>;", "<cmd>Nvdash<cr>", {
  desc = "Return to dashboard",
})
map("n", ";", ":", {
  desc = "CMD enter command mode",
  nowait = true,
})
map("n", "-", function()
  require("oil").open()
end, {
  desc = "Open parent directory",
})
map("n", "J", "mzJ`z", {
  desc = "Remove line break",
})

-- Resenters screen after jumping (Note scrol down add 1 line to correct for navic)
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
map("n", "<Esc>", function()
  vim.cmd [[noh]]
  require("noice.lsp.docs").on_close()
end, {
  desc = "Close",
})
map("n", "<C-f>", function()
  if not require("noice.lsp").scroll(4) then
    return "<c-f>"
  end
end, {
  desc = "Scroll down",
  silent = true,
  expr = true,
})
map("n", "<C-b>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<c-b>"
  end
end, {
  desc = "Scroll up",
  silent = true,
  expr = true,
})
map("n", "<leader>fr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
  desc = "Replace section",
})
map("n", "<leader>Q", "<cmd>xa<cr>", {
  desc = "Save All and Quit",
})
map("n", "<C-w>f", "<cmd>FocusToggle<cr>", {
  desc = "Toggle Focus",
})

map("i", "<C-c>", "<Esc>", {
  desc = "Return to normal mode",
})
map("i", "<C-f>", function()
  if not require("noice.lsp").scroll(4) then
    return "<c-f>"
  end
end, {
  desc = "Scroll down",
  silent = true,
  expr = true,
})
map("i", "<C-b>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<c-b>"
  end
end, {
  desc = "Scroll up",
  silent = true,
  expr = true,
})

map("s", "<C-f>", function()
  if not require("noice.lsp").scroll(4) then
    return "<c-f>"
  end
end, {
  desc = "Scroll down",
  silent = true,
  expr = true,
})
map("s", "<C-b>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<c-b>"
  end
end, {
  desc = "Scroll up",
  silent = true,
  expr = true,
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

-- Noise
map("n", "<leader>n", "<cmd>Noice telescope<cr>", {
  desc = "Notifications",
})

-- Neotest
map("n", "<leader>ct", function()
  require("neotest").run.run()
end, {
  desc = "Run nearest test",
})
map("n", "<leader>cf", function()
  require("neotest").run.run(vim.fn.expand "%")
end, {
  desc = "Run file tests",
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

map("n", "<leader>gl", function()
  local Snacks = require "snacks"
  Snacks.gitbrowse.open()
end, {
  desc = "vsc Open in GitHub",
})
map("n", "<leader>gP", function()
  local nvterm = require "nvchad.term"
  nvterm.runner { pos = "float", id = "gh", cmd = "gh pr create" }
end, {
  desc = "vsc pr create",
})
map("n", "<leader>gP", "<cmd>Octo pr list<CR>", {
  desc = "vsc pr list",
})
map("n", "<leader>gi", "<cmd>Octo issue list<CR>", {
  desc = "vsc issue list",
})
map("n", "<leader>go", "<cmd>Octo actions<CR>", {
  desc = "vsc list actions",
})
map("n", "<leader>gt", "<cmd>Telescope git_status<cr>", {
  desc = "vsc status",
})
map("n", "<leader>gC", "<cmd>Telescope git_commits<cr>", {
  desc = "vsc commit list",
})
map("v", "<leader>gl", function()
  local Snacks = require "snacks"
  Snacks.gitbrowse.open()
end, {
  desc = "vsc Open in GitHub",
})

-- Session
map("n", "<leader>ss", "<cmd>lua require('persistence').load()<cr>", {
  desc = "Reload last session for dir",
})
map("n", "<leader>sl", "<cmd>lua require('persistence').load({ last = true })<cr>", {
  desc = "Restore last session",
})
map("n", "<leader>sQ", "<cmd>lua require('persistence').stop()<cr>", {
  desc = "Quit without saving session",
})

-- lspconfig

map("n", "<leader>lf", "<cmd>EslintFixAll<cr>", {
  desc = "LSP Fix all",
})
map("n", "<leader>ld", "<cmd>Trouble diagnostics<cr>", {
  desc = "LSP Diagnostics",
})
map("n", "<leader>lt", "<CMD>TodoTrouble keywords=TODO,FIX,FIXME,BUG,TEST,NOTE<CR>", {
  desc = "LSP Todo/Fix/Fixme",
})

map("n", "<leader>lR", function()
  if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
    require("vtsls").commands.restart_tsserver()
  end

  vim.diagnostic.reset()
  vim.cmd [[LspRestart]]
end, {
  desc = "LSP Restart Language Server",
})

map("n", "<leader>ci", function()
  require("vtsls").commands.remove_unused_imports()
end, {
  desc = "TypeScript Remove Unused Imports",
})
map("n", "<leader>cI", function()
  require("vtsls").commands.add_missing_imports()
end, {
  desc = "TypeScript Add Missing Imports",
})
map("n", "<leader>rf", function()
  require("vtsls").commands.rename_file()
end, {
  desc = "TypeScript Rename File",
})

map("n", "<leader>ca", function()
  require("actions-preview").code_actions()
end, {
  desc = "LSP Code action",
})
map("v", "<leader>ca", function()
  require("actions-preview").code_actions()
end, {
  desc = "LSP Code action",
})

-- Telescope

map("n", "<leader>fW", function()
  require("telescope.builtin").grep_string { search = vim.fn.expand "<cword>" }
end, {
  desc = "Telescope Find word under cursor",
})
map("n", "<leader>fs", "<cmd>Telescope ast_grep<cr>", {
  desc = "Telescope Find AST",
})
map("n", "<leader>fi", "<cmd>Telescope import<cr>", {
  desc = "Telescope Find import",
})
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", {
  desc = "Telescope Find keymaps",
})
map("n", "\\", "<cmd>Telescope resume<cr>", {
  desc = "Telescope Resume last search",
})

-- Harpoon
map("n", "<leader>mm", "<cmd>lua require('harpoon'):list():add()<cr>", {
  desc = "Mark file",
})
map("n", "<leader>mt", function()
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
end, {
  desc = "Toggle UI",
})
map("n", "<leader>ma", "<cmd>lua require('harpoon'):list():select(1)<cr>", {
  desc = "Goto mark 1",
})
map("n", "<leader>ms", "<cmd>lua require('harpoon'):list():select(2)<cr>", {
  desc = "Goto mark 2",
})
map("n", "<leader>md", "<cmd>lua require('harpoon'):list():select(3)<cr>", {
  desc = "Goto mark 3",
})
map("n", "<leader>mf", "<cmd>lua require('harpoon'):list():select(4)<cr>", {
  desc = "Goto mark 4",
})
map("n", "<leader>mg", "<cmd>lua require('harpoon'):list():select(5)<cr>", {
  desc = "Goto mark 5",
})
map("n", "<leader>mq", "<cmd>lua require('harpoon'):list():select(6)<cr>", {
  desc = "Goto mark 6",
})
map("n", "<leader>mw", "<cmd>lua require('harpoon'):list():select(7)<cr>", {
  desc = "Goto mark 7",
})
map("n", "<leader>me", "<cmd>lua require('harpoon'):list():select(8)<cr>", {
  desc = "Goto mark 8",
})
map("n", "<leader>mr", "<cmd>lua require('harpoon'):list():select(9)<cr>", {
  desc = "Goto mark 9",
})
map("n", "<leader>mn", "<cmd>lua require('harpoon'):list():next()<cr>", {
  desc = "Next file",
})
map("n", "<leader>mN", "<cmd>lua require('harpoon'):list():prev()<cr>", {
  desc = "Prev file",
})

-- Outline
map("n", "<leader>O", "<cmd>Outline<cr>", {
  desc = "Toggle Outline",
})

-- Code
map("n", "<leader>0", function()
  local Snacks = require "snacks"
  Snacks.zen()
end, {
  desc = "Zen Mode",
})
map("n", "<leader>cj", "<cmd>lua require('treesj').toggle()<cr>", {
  desc = "Open block",
})

-- Quickfix
map("n", "Q", function()
  local trouble = require "trouble"
  if trouble.is_open() then
    trouble.close()
  else
    -- try to require qf_helper if it fails then skip
    local call = pcall(require, "qf_helper")
    if call then
      vim.cmd [[Cclose]]
    end
  end
end, {
  desc = "Close Quickfix",
})
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

-- Compile
map("n", "<D-b>", "<cmd>CompilerOpen<cr>", {
  desc = "Open compiler",
})
map("n", "<D-B>", "<cmd>CompilerStop<cr><cmd>CompilerRedo<cr>", {
  desc = "Stop and redo",
})
map("n", "<D-r>", "<cmd>CompilerToggleResults<cr>", {
  desc = "Toggle results",
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

-- Snippets
map("n", "<leader>se", function()
  require("scissors").editSnippet()
end, { desc = "Edit snippet" })

map({ "n", "x" }, "<leader>sa", function()
  require("scissors").addNewSnippet()
end, { desc = "Add new snippet" })

-- Menu
vim.keymap.set("n", "<C-t>", function()
  require("menu").open "default"
end, {})

vim.keymap.set("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

-- Remove default keymaps
local unmap = vim.keymap.del

unmap("n", "<leader>rn")
