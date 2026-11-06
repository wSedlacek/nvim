local M = {}

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "T3 Code" })
end

local function run(args, opts)
  opts = opts or {}
  local output = {}
  local job = vim.fn.jobstart(args, {
    cwd = opts.cwd or vim.fn.getcwd(),
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      for _, line in ipairs(data) do
        if line ~= "" then
          table.insert(output, line)
        end
      end
    end,
    on_stderr = function(_, data)
      for _, line in ipairs(data) do
        if line ~= "" then
          table.insert(output, line)
        end
      end
    end,
    on_exit = function(_, code)
      local text = table.concat(output, "\n")
      if opts.on_exit then
        opts.on_exit(code, text)
        return
      end
      if code == 0 then
        notify(text ~= "" and text or "ok")
      else
        notify(text ~= "" and text or ("exit " .. code), vim.log.levels.ERROR)
      end
    end,
  })
  if job <= 0 then
    notify("failed to start: " .. table.concat(args, " "), vim.log.levels.ERROR)
  end
end

function M.app()
  run { "t3", "app", "." }
end

function M.list()
  require("nvchad.term").runner {
    pos = "float",
    id = "t3-list",
    cmd = "t3 thread list --project .; echo; printf 'press enter…'; read",
  }
end

function M.start()
  vim.ui.input({ prompt = "T3 thread message: " }, function(msg)
    if not msg or vim.trim(msg) == "" then
      return
    end
    run({ "t3", "thread", "start", ".", msg }, {
      on_exit = function(code, text)
        if code ~= 0 then
          notify(text ~= "" and text or ("exit " .. code), vim.log.levels.ERROR)
          return
        end
        notify(text ~= "" and ("started\n" .. text) or "started")
      end,
    })
  end)
end

function M.setup()
  if vim.fn.executable "t3" ~= 1 then
    return
  end

  local map = vim.keymap.set
  map("n", "<leader>at", M.start, { desc = "T3 start thread" })
  map("n", "<leader>aT", M.app, { desc = "T3 open app" })
  map("n", "<leader>al", M.list, { desc = "T3 list threads" })
end

return M
