local function setup()
	vim.pack.add {
		"https://github.com/mfussenegger/nvim-dap",
		"https://github.com/igorlfs/nvim-dap-view",
		"https://github.com/theHamsta/nvim-dap-virtual-text",
		"https://github.com/Weissle/persistent-breakpoints.nvim",
	}
	local dap = require "dap"
	dap.adapters["pwa-node"] = {
		type = "server",
		host = "localhost",
		port = "8123",
		executable = { command = "js-debug-dap" },
	}
	for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact" } do
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
			{ name = "---- launch.json ----", type = "", request = "launch" },
		}
	end
	local ui = require "dap-view"
	local vt = require "nvim-dap-virtual-text"
	local bp = require "persistent-breakpoints.api"
	vt.setup {}
	ui.setup {
		windows = { position = "right", terminal = { start_hidden = true } },
		winbar = {
			sections = { "watches", "repl", "scopes", "breakpoints", "exceptions", "threads" },
			default_section = "repl",
		},
	}

	vim.keymap.set("n", "<leader>d", "<nop>", { desc = "debug" })
	vim.keymap.set("n", "<leader>db", bp.toggle_breakpoint, { desc = "breakpoint" })
	vim.keymap.set("n", "<leader>dB", bp.set_conditional_breakpoint, { desc = "conditional breakpoint" })
	vim.keymap.set("n", "<leader>dc", bp.clear_all_breakpoints, { desc = "clear breakpoints" })
	vim.keymap.set("n", "<leader>dl", bp.set_log_point, { desc = "log point breakpoints" })

	vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "continue" })
	vim.keymap.set("n", "<leader>d.", dap.run_to_cursor, { desc = "run to cursor" })
	vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "step into" })
	vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "step over" })
	vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "step out" })
	vim.keymap.set("n", "<leader>dt", ui.toggle, { desc = "toggle ui" })
	vim.keymap.set("n", "<leader>dv", vt.toggle, { desc = "toggle virtual text" })
	vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "restart" })
	vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "terminate" })

	dap.listeners.before.attach.dapui_config = ui.open
	dap.listeners.before.launch.dapui_config = ui.open
	dap.listeners.before.event_terminated.dapui_config = ui.close
	dap.listeners.before.event_exited.dapui_config = ui.close
end
vim.api.nvim_create_user_command("DbgEnable", setup, {})
