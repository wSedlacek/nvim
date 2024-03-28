---@type NvPluginSpec
return {
  "folke/noice.nvim",
  event = "UIEnter",
  dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  opts = {
    cmdline = {
      format = {
        cmdline = {
          title = "",
          icon = "  ",
        },
        lua = {
          title = "",
          icon = " 󰢱 ",
        },
        help = {
          title = "",
          icon = " 󰋖 ",
        },
        input = {
          title = "",
          icon = "  ",
        },
        filter = {
          title = "",
          icon = "  ",
        },
        search_up = {
          icon = "    ",
        },
        search_down = {
          icon = "    ",
        },
      },
      opts = {
        win_options = {
          winhighlight = {
            -- Normal = "NormalFloat",
            FloatBorder = "FloatBorder",
          },
        },
      },
    },
    popupmenu = {
      -- backend = "cmp", -- Has issues after first completion
    },
    views = {
      cmdline_popup = {
        border = {
          style = { " ", " ", " ", " ", " ", " ", " ", " " },
          padding = { 0, 1 },
        },
      },
      cmdline_popupmenu = {
        border = {
          style = { " ", " ", " ", " ", " ", " ", " ", " " },
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = {
            Normal = "NormalFloat",
            FloatBorder = "FloatBorder",
          },
        },
      },
    },

    lsp = {
      signature = {
        enabled = false,
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = {
        enabled = false,
        silent = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    messages = {
      view_history = false,
      view_search = false,
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
            { find = "%d fewer lines" },
            { find = "%d more lines" },
            { find = "%d lines yanked" },
            { find = "(%d of %d)" },
          },
        },
        opts = { skip = true },
      },

      -- angularls runs at the same time as typescirpt-tools and does not find references
      {
        filter = {
          any = {
            { find = "No information available" },
            { find = "No references found" },
            { find = "No lines in buffer" },
          },
        },
        opts = { skip = true },
      },
    },
  },
}
