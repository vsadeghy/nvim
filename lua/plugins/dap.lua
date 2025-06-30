return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui", dependencies = "nvim-neotest/nvim-nio" },
    "theHamsta/nvim-dap-virtual-text",
    "Weissle/persistent-breakpoints.nvim",
  },
  config = function()
    local dap = require "dap"
    local ui = require "dapui"
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "8123",
      executable = {
        command = "js-debug-adapter",
      },
    }

    for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact" } do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end

    local vt = require "nvim-dap-virtual-text"
    local bp = require "persistent-breakpoints.api"
    vt.setup {}
    ui.setup()
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

    -- Eval var under cursor
    map("n", "<leader>dk", function()
      ui.eval(nil, { enter = true })
    end, "eval var under cursor")

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
  keys = { { "<leader>db" }, { "<leader>ds" } },
}
