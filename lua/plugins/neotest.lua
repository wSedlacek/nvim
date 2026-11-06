---@type NvPluginSpec
return {
  "nvim-neotest/neotest",
  event = "VeryLazy",
  keys = {
    {
      "<leader>ct",
      function() require("neotest").run.run() end,
      desc = "Run nearest test",
    },
    {
      "<leader>cf",
      function() require("neotest").run.run(vim.fn.expand "%") end,
      desc = "Run file tests",
    },
    {
      "<leader>cT",
      function() require("neotest").run.run(vim.fn.getcwd()) end,
      desc = "Run all tests",
    },
    {
      "<leader>cs",
      function() require("neotest").summary.toggle() end,
      desc = "Toggle test summary",
    },
    {
      "<leader>co",
      function() require("neotest").output.open { enter = true, auto_close = true } end,
      desc = "Show test output",
    },
    {
      "<leader>cO",
      function() require("neotest").output_panel.toggle() end,
      desc = "Toggle output panel",
    },
    {
      "<leader>cw",
      function() require("neotest").watch.toggle(vim.fn.expand "%") end,
      desc = "Toggle test watch",
    },
    {
      "<leader>cS",
      function() require("neotest").run.stop() end,
      desc = "Stop tests",
    },
    {
      "<leader>cd",
      function() require("neotest").run.run { strategy = "dap" } end,
      desc = "Debug nearest test",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "rouge8/neotest-rust",
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
    "mmllr/neotest-swift-testing",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local lib = require "neotest.lib"

    local vitest_config_names = {
      "vitest.config.ts",
      "vitest.config.js",
      "vitest.config.mts",
      "vitest.config.mjs",
      "vite.config.ts",
      "vite.config.js",
      "vite.config.mts",
      "vite.config.mjs",
    }

    local jest_config_names = {
      "jest.config.ts",
      "jest.config.js",
      "jest.config.mjs",
      "jest.config.cjs",
      "jest.config.json",
    }

    ---@param start string|nil
    ---@param names string[]
    ---@return string|nil
    local function find_up(start, names)
      local path = start
      if not path or path == "" then
        path = vim.api.nvim_buf_get_name(0)
      end
      if path == "" then
        path = vim.fn.getcwd()
      end

      local dir = vim.fn.isdirectory(path) == 1 and path or vim.fs.dirname(path)
      if not dir or dir == "" then
        return nil
      end

      ---@param directory string
      ---@return string|nil
      local function check(directory)
        for _, name in ipairs(names) do
          local candidate = directory .. "/" .. name
          if vim.uv.fs_stat(candidate) then
            return candidate
          end
        end
      end

      local found = check(dir)
      if found then
        return found
      end
      for ancestor in vim.fs.parents(dir) do
        found = check(ancestor)
        if found then
          return found
        end
      end
    end

    ---@param path string
    ---@return boolean
    local function looks_like_js_test(path)
      if path:find "__tests__" then
        return true
      end
      for _, kind in ipairs { "e2e", "spec", "test" } do
        for _, ext in ipairs { "js", "jsx", "ts", "tsx" } do
          if path:match("%." .. kind .. "%." .. ext .. "$") then
            return true
          end
        end
      end
      return false
    end

    local vitest_dep_keys = {
      vitest = true,
      ["@vitest/ui"] = true,
      ["@vitest/coverage-v8"] = true,
      ["@effect/vitest"] = true,
      ["vite-plus"] = true,
    }

    ---@param package_json string
    ---@return boolean
    local function package_has_vitest_like(package_json)
      local ok, content = pcall(lib.files.read, package_json)
      if not ok or not content then
        return false
      end
      local decoded_ok, pkg = pcall(vim.json.decode, content)
      if not decoded_ok or type(pkg) ~= "table" then
        return false
      end
      for _, section in ipairs { "dependencies", "devDependencies", "peerDependencies" } do
        local deps = pkg[section]
        if type(deps) == "table" then
          for key, _ in pairs(deps) do
            if vitest_dep_keys[key] then
              return true
            end
          end
        end
      end
      return false
    end

    ---@param file_path string
    ---@return boolean
    local function has_vitest_like_dependency(file_path)
      for ancestor in vim.fs.parents(file_path) do
        local pkg = ancestor .. "/package.json"
        if vim.uv.fs_stat(pkg) and package_has_vitest_like(pkg) then
          return true
        end
      end
      return false
    end

    ---@param path string
    ---@return string
    local function vitest_command(path)
      local search_roots = {}
      local node_modules_root = lib.files.match_root_pattern "node_modules"(path)
      if node_modules_root then
        search_roots[#search_roots + 1] = node_modules_root
      end
      local pkg_root = lib.files.match_root_pattern "package.json"(path)
      if pkg_root and pkg_root ~= node_modules_root then
        search_roots[#search_roots + 1] = pkg_root
      end

      for _, root in ipairs(search_roots) do
        local vitest_bin = root .. "/node_modules/.bin/vitest"
        if vim.uv.fs_stat(vitest_bin) then
          return vitest_bin
        end
      end

      for _, root in ipairs(search_roots) do
        local vp_bin = root .. "/node_modules/.bin/vp"
        if vim.uv.fs_stat(vp_bin) then
          return vp_bin .. " test"
        end
      end

      if vim.fn.executable "vp" == 1 and has_vitest_like_dependency(path) then
        return "vp test"
      end

      return "vitest"
    end

    --- Wrap vitest so @effect/vitest / vite-plus projects are recognized.
    --- neotest-vitest's opts.is_test_file is ANDed with a narrow hasVitestDependency
    --- check that misses those packages, so replace is_test_file after construction.
    ---@param adapter neotest.Adapter
    ---@return neotest.Adapter
    local function with_vitest_compat(adapter)
      local original = adapter.is_test_file
      adapter.is_test_file = function(file_path)
        if file_path == nil then
          return false
        end
        if original(file_path) then
          return true
        end
        return looks_like_js_test(file_path) and has_vitest_like_dependency(file_path)
      end
      return adapter
    end

    --- neotest may assign directory runs (e.g. <leader>cT on ~/.config/nvim) to any
    --- registered adapter. Upstream build_spec asserts when Package.swift is missing;
    --- return nil instead so neotest skips / breaks the tree down quietly.
    ---@param adapter neotest.Adapter
    ---@return neotest.Adapter
    local function with_swift_root_guard(adapter)
      local original_is_test_file = adapter.is_test_file
      local original_build_spec = adapter.build_spec

      adapter.is_test_file = function(file_path)
        if file_path == nil or not original_is_test_file(file_path) then
          return false
        end
        return adapter.root(file_path) ~= nil
      end

      adapter.build_spec = function(args)
        if not args or not args.tree then
          return nil
        end
        local position = args.tree:data()
        if not position or not position.path or not adapter.root(position.path) then
          return nil
        end
        return original_build_spec(args)
      end

      return adapter
    end

    require("neotest").setup {
      adapters = {
        require "neotest-jest" {
          jestConfigFile = function(file_path)
            return find_up(file_path, jest_config_names)
          end,
          cwd = function(file_path)
            local cfg = find_up(file_path, jest_config_names)
            if cfg then
              return vim.fs.dirname(cfg)
            end
            return vim.fn.getcwd()
          end,
        },
        with_vitest_compat(require "neotest-vitest" {
          vitestCommand = vitest_command,
          vitestConfigFile = function(file_path)
            return find_up(file_path, vitest_config_names)
          end,
          cwd = function(file_path)
            local cfg = find_up(file_path, vitest_config_names)
            if cfg then
              return vim.fs.dirname(cfg)
            end
            local pkg_root = lib.files.match_root_pattern "package.json"(file_path)
            if pkg_root then
              return pkg_root
            end
            return vim.fn.getcwd()
          end,
          filter_dir = function(name)
            return name ~= "node_modules"
              and name ~= "dist"
              and name ~= "build"
              and name ~= ".git"
              and name ~= "coverage"
          end,
        }),
        with_swift_root_guard(require "neotest-swift-testing"),
        require "neotest-rust" {
          args = { "--no-capture" },
          dap_adapter = "codelldb",
        },
      },
      discovery = {
        enabled = true,
        concurrent = true,
      },
      diagnostic = {
        enabled = true,
        severity = vim.diagnostic.severity.ERROR,
      },
      output = {
        open_on_run = "short",
      },
      output_panel = {
        enabled = true,
      },
      quickfix = {
        open = false,
      },
      status = {
        enabled = true,
        signs = true,
        virtual_text = true,
      },
      floating = {
        border = "rounded",
        max_height = 0.8,
        max_width = 0.9,
      },
    }
  end,
}
