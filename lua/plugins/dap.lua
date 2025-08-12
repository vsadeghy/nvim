return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- { "rcarriga/nvim-dap-ui", dependencies = "nvim-neotest/nvim-nio" },
    "igorlfs/nvim-dap-view",
    "theHamsta/nvim-dap-virtual-text",
    "Weissle/persistent-breakpoints.nvim",
  },
  config = function()
    local dap = require "dap"
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "8123",
      executable = {
        command = "js-debug-adapter",
      },
    }
    -- dap.adapters["pwa-chrome"] = {
    --   type = "executable",
    --   command = "pwa-chrome",
    --   args = { "--remote-debugging-port=9222" },
    -- }

    local languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
    for _, language in ipairs(languages) do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        -- {
        --   type = "pwa-chrome",
        --   request = "attach",
        --   name = "Launch & Debug Chrome",
        --   url = function()
        --     local co = coroutine.running()
        --     return coroutine.create(function()
        --       vim.ui.input({ prompt = "URL: ", default = "http://localhost:3000" }, function(url)
        --         if url == nil or url == "" then
        --           return
        --         else
        --           coroutine.resume(co, url)
        --         end
        --       end)
        --     end)
        --   end,
        --   webRoot = "${workspaceFolder}",
        --   skipFiles = { "<node_internals>/**/*.js" },
        --   sourceMaps = true,
        --   userDataDir = false,
        -- },
        {
          name = "---- launch.json ----",
          type = "",
          request = "launch",
        },
      }
    end

    local ui = require "dap-view"
    local vt = require "nvim-dap-virtual-text"
    local bp = require "persistent-breakpoints.api"
    vt.setup {}
    ui.setup { windows = { terminal = { hide = {} } } }
    require("persistent-breakpoints").setup {
      load_breakpoints_event = { "BufReadPost" },
    }

    local map = function(mode, key, func, desc, opts)
      local options = { silent = true }
      if desc then
        options = vim.tbl_extend("force", options, { desc = desc })
      end
      options = vim.tbl_extend("force", options, opts or {})
      vim.keymap.set(mode, key, func, options)
    end

    map("n", "<leader>d", "<nop>")
    map("n", "<leader>db", bp.toggle_breakpoint, "breakpoint")
    map("n", "<leader>dB", bp.set_conditional_breakpoint, "breakpoint")
    map("n", "<leader>dc", bp.clear_all_breakpoints, "clear breakpoints")
    map("n", "<leader>dc", bp.set_log_point, "clear breakpoints")
    map("n", "<leader>d.", dap.run_to_cursor, "run to cursor")
    map("n", "<leader>da", function()
      if vim.fn.filereadable ".vscode/launch.json" then
        local vscode = require "dap.ext.vscode"
        vscode.load_launchjs(nil, {
          ["pwa-node"] = languages,
          ["pwa-chrome"] = languages,
          ["node"] = languages,
          ["chrome"] = languages,
        })
        dap.continue()
      end
    end, "run with args")

    -- Eval var under cursor
    -- map("n", "<leader>dk", function()
    --   ui.eval(nil, { enter = true })
    -- end, "eval var under cursor")

    map("n", "<leader>ds", dap.continue, "continue")
    map("n", "<leader>di", dap.step_into, "step into")
    map("n", "<leader>do", dap.step_over, "step over")
    map("n", "<leader>dO", dap.step_out, "step out")
    map("n", "<leader>dB", dap.step_back, "step back")
    map("n", "<leader>dt", ui.toggle, "toggle ui")
    map("n", "<leader>dv", vt.toggle, "toggle virtual text")
    map("n", "<leader>dr", dap.restart, "restart")
    map("n", "<leader>dq", dap.terminate, "terminate")

    dap.listeners.before.attach.dapui_config = ui.open
    dap.listeners.before.launch.dapui_config = ui.open
    dap.listeners.before.event_terminated.dapui_config = ui.close
    dap.listeners.before.event_exited.dapui_config = ui.close
  end,
  -- keys = { { "<leader>db" }, { "<leader>ds" } },
}
