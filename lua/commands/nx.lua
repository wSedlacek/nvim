vim.api.nvim_create_user_command("NxInit", function()
  local lspClients = vim.lsp.get_active_clients()
  local tsclient
  for _, client in ipairs(lspClients) do
    if client.name == "vtsls" then
      tsclient = client
    end
  end

  if not tsclient then
    print "nvim-vtsls not active"
    return
  end

  local workspacePath = tsclient.config.workspace_folders[1].name
  if not workspacePath then
    print "Could not figure out workspace path"
    return
  end

  print "Running nx init..."
  local now = tostring(os.time())
  local fileName = workspacePath .. "/" .. string.format("%s_graph.json", now)
  local cmd = string.format("npx nx graph --file=%s", fileName)

  local function handle_response(_, code)
    local projectGraphFile = io.open(fileName, "r")
    if projectGraphFile == nil then
      print "Could not find project graph file"
      return
    end

    if projectGraphFile then
      local projectGraph = vim.json.decode(projectGraphFile:read "*a")
      projectGraphFile:close()
      os.remove(fileName)

      local externalFiles = {}
      for _, project in pairs(projectGraph.graph.nodes) do
        local sourceRoot = project.data.sourceRoot
        local root = project.data.root

        if sourceRoot ~= "." and sourceRoot then
          local mainFile
          local directory = workspacePath .. "/" .. root

          if
            project.data
            and project.data.targets
            and project.data.targets.build
            and project.data.targets.build.options
            and project.data.targets.build.options.main
          then
            mainFile = workspacePath .. "/" .. project.data.targets.build.options.main
          else
            mainFile = workspacePath .. "/" .. sourceRoot .. "/index.ts"
          end

          if vim.fn.filereadable(mainFile) and vim.fn.isdirectory(directory) then
            table.insert(externalFiles, {
              mainFile = mainFile,
              directory = directory,
            })
          end
        end
      end

      tsclient.request("workspace/executeCommand", {
        command = "_typescript.configurePlugin",
        arguments = {
          "@monodon/typescript-nx-imports-plugin",
          { externalFiles = externalFiles },
        },
      }, function(err, res)
        if err then
          vim.print("Error: ", err)
          return
        end

        vim.print "Done!"
      end)
    end
  end

  local job_id = vim.fn.jobstart(cmd, {
    on_exit = handle_response,
    stdout_buffered = true,
    stderr_buffered = true,
    cwd = workspacePath,
  })
end, {})
