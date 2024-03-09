if vim.g.neovide then
  vim.o.guifont = "IosevkaTerm Nerd Font Mono:h16"
  vim.opt.linespace = 0 -- Causes cmd to have gaps

  vim.o.shell = "fish"

  vim.g.neovide_window_blurred = true
  vim.g.neovide_transparency = 0.9
  vim.g.transparency = 1

  vim.g.neovide_show_border = false
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5

  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 8
  vim.g.neovide_padding_left = 8

  vim.g.neovide_input_macos_alt_is_meta = true

  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_underline_automatic_scaling = true
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_profiler = false
  vim.g.neovide_cursor_vfx_mode = ""

  -- https://github.com/neovide/neovide/pull/2165
  vim.g.neovide_scroll_animation_length = 0

  local currect_directory = vim.fn.getcwd()

  if currect_directory == "/" then
    local path_to_desktop = "~/Code"

    local vim_enter_group = vim.api.nvim_create_augroup("vim_enter_group", { clear = true })

    vim.api.nvim_create_autocmd(
      { "VimEnter" },
      { pattern = "*", command = "cd " .. path_to_desktop, group = vim_enter_group }
    )
  end
end
