if vim.g.neovide then
  vim.o.guifont = "IosevkaTerm Nerd Font Mono:h16"
  vim.opt.linespace = 0

  vim.o.shell = "fish"

  vim.g.neovide_opacity = 0.75
  vim.g.transparency = 1

  vim.g.neovide_floating_corner_radius = 0.5

  vim.g.neovide_show_border = false
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5

  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 8
  vim.g.neovide_padding_left = 8

  vim.g.neovide_input_macos_option_key_is_meta = "both"

  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_underline_automatic_scaling = true
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_profiler = false
  vim.g.neovide_cursor_vfx_mode = ""
  vim.g.neovide_cursor_animate_in_insert_mode = true

  vim.schedule(function()
    local current_directory = vim.fn.getcwd()
    local home_directory = vim.fn.expand "~"
    if current_directory == "/" or current_directory == home_directory then
      local cored_directory = "~/Code"
      vim.cmd("cd " .. cored_directory)
    end
  end)

  -- https://github.com/neovide/neovide/issues/1771
  vim.api.nvim_create_autocmd({ "BufLeave", "BufNew", "WinEnter", "WinNew" }, {
    callback = function()
      vim.g.neovide_scroll_animation_length = 0
      vim.g.neovide_cursor_animation_length = 0
    end,
  })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufNew", "WinEnter", "WinNew" }, {
    callback = function()
      vim.fn.timer_start(32, function()
        vim.g.neovide_scroll_animation_length = 0.5
        vim.g.neovide_cursor_animation_length = 0.08
      end)
    end,
  })
end
