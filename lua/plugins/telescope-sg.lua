---@type NvPluginSpec
return {
  "Marskey/telescope-sg",
  config = function()
    require("telescope").load_extension "ast_grep"
  end,
}
