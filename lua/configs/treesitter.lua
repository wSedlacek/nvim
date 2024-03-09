local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.swift = vim.tbl_extend("force", parser_config.swift, {
  install_info = vim.tbl_extend("force", parser_config.swift.install_info, {}),
})

-- Autocmd that runs on Filetype which runs TSBufDisable indent for swift files
-- vim.api.nvim_create_augroup("remove_swift_indents", { clear = true })
-- vim.api.nvim_create_autocmd("Filetype", {
--   pattern = "swift",
--   group = "remove_swift_indents",
--   callback = function()
--     vim.cmd [[TSBufDisable indent]]
--   end,
-- })

-- parser_config.angular = {
--   install_info = {
--     url = "~/Code/tree-sitter-angular",
--     files = { "src/parser.c", "src/scanner.c" },
--     branch = "main",
--   },
--   filetype = "angular",
-- }
