--- @type NvPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "vim",
      "vimdoc",
      "lua",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "markdown",
      "markdown_inline",
      "bash",
      "regex",
      "helm",
      "proto",
    },
  },
  config = function(_, opts)
    -- Highlighting is started by NvChad via vim.treesitter.start().
    -- Indent is no longer a treesitter "module"; wire it through indentexpr.
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("UserTreesitterIndent", { clear = true }),
      callback = function(args)
        local disable = { swift = true, text = true }
        if disable[args.match] then return end
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    -- NvChad's TSInstallAll reads ensure_installed from the lazy plugin opts.
    if opts.ensure_installed and #opts.ensure_installed > 0 then
      require("nvim-treesitter").install(opts.ensure_installed)
    end
  end,
}
