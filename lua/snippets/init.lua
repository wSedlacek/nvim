vim.g.vscode_snippets_path = {
  -- vim.fn.stdpath "config" .. "/lua/snippets/vscode/angular",
  -- vim.fn.stdpath "config" .. "/lua/snippets/vscode/golang",
  -- vim.fn.stdpath "config" .. "/lua/snippets/vscode/jest",
  -- vim.fn.stdpath "config" .. "/lua/snippets/vscode/kubernetes",
  -- vim.fn.stdpath "config" .. "/lua/snippets/vscode/nginx",
  -- vim.fn.stdpath "config" .. "/lua/snippets/vscode/nu",
  -- vim.fn.stdpath "config" .. "/lua/snippets/vscode/schematics",
  -- vim.fn.stdpath "config" .. "/lua/snippets/vscode/shell",
  -- vim.fn.stdpath "config" .. "/lua/snippets/vscode/spectator",
  -- vim.fn.stdpath "config" .. "/lua/snippets/vscode/storybook",
  -- vim.fn.stdpath "config" .. "/lua/snippets/vscode/terraform",
  -- vim.fn.stdpath "config" .. "/lua/snippets/vscode/typescript",
  vim.fn.stdpath "config" .. "/lua/snippets/vscode/custom",
}

vim.g.vscode_snippets_exclude = { "all" }
vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/snippets/lua"
