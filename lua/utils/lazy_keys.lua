local M = {}

-- Save all keymaps registered by lazy-loaded plugins
function M.save()
  local modes = { "n", "v", "x", "s", "o", "i", "c", "t" }
  local lazy_keys = {}

  for _, mode in ipairs(modes) do
    lazy_keys[mode] = {}
    for _, keymap in ipairs(vim.api.nvim_get_keymap(mode)) do
      -- Lazy.nvim marks its keymaps with special descriptions
      if keymap.desc and keymap.desc:match "^%[%[" then
        lazy_keys[mode][keymap.lhs] = keymap
      end
    end
  end

  return lazy_keys
end

-- Restore lazy-loaded plugin keymaps that were overwritten
function M.restore(lazy_keys)
  for mode, keymaps in pairs(lazy_keys) do
    for lhs, keymap in pairs(keymaps) do
      local current = vim.fn.maparg(lhs, mode, false, true)

      -- If the keymap changed or was removed, restore the lazy version
      if vim.tbl_isempty(current) or (current.callback ~= keymap.callback and current.rhs ~= keymap.rhs) then
        local opts = {
          desc = keymap.desc,
          callback = keymap.callback,
          expr = keymap.expr == 1,
          noremap = keymap.noremap == 1,
          nowait = keymap.nowait == 1,
          silent = keymap.silent == 1,
        }

        if keymap.callback then
          vim.keymap.set(mode, lhs, keymap.callback, opts)
        elseif keymap.rhs then
          vim.keymap.set(mode, lhs, keymap.rhs, opts)
        end
      end
    end
  end
end

return M
