--- @param cmd? string
--- @param split? "left" | "right" | "above" | "below"
local function fterm(cmd, split)
	local term_state = {
		buf = nil,
		win = nil,
		is_open = false,
	}
	local function close()
		if term_state.is_open then
			vim.api.nvim_win_close(term_state.win, false)
			term_state.is_open = false
			return true
		end
	end

	return function()
		if close() then return end
		if not term_state.buf then
			term_state.buf = vim.api.nvim_create_buf(false, true)
			vim.keymap.set("t", "<C-q>", close, { buffer = term_state.buf, desc = "close fterm" })
			vim.api.nvim_set_option_value("bufhidden", "hide", { buf = term_state.buf })
		end

		---@type vim.api.keyset.win_config
		local config
		if split then
			config = { split = split }
		else
			local width = math.floor(vim.o.columns * 0.8)
			local height = math.floor(vim.o.lines * 0.8)
			local row = math.floor((vim.o.lines - height) / 2)
			local col = math.floor((vim.o.columns - width) / 2)
			config = {
				width = width,
				height = height,
				row = row,
				col = col,
				relative = "editor",
				style = "minimal",
				border = "rounded",
			}
		end
		term_state.win = vim.api.nvim_open_win(term_state.buf, true, config)
		local has_terminal = false
		local lines = vim.api.nvim_buf_get_lines(term_state.buf, 0, -1, false)
		for _, line in ipairs(lines) do
			if line ~= "" then
				has_terminal = true
				break
			end
		end

		if not has_terminal then vim.fn.jobstart(cmd or vim.o.shell, { term = true }) end
		term_state.is_open = true
		vim.cmd "startinsert"

		-- vim.api.nvim_create_autocmd("BufLeave", {
		--   buffer = term_state.buf,
		--   callback = close,
		-- })
		vim.api.nvim_create_autocmd("TermClose", {
			buffer = term_state.buf,
			callback = function()
				close()
				term_state.buf = nil
				term_state.win = nil
			end,
		})
	end
end

vim.keymap.set({ "n", "t" }, "<leader>t", fterm(nil, "right"), { desc = "open fterm" })
vim.keymap.set({ "n", "t" }, "<leader>y", fterm "yazi", { desc = "open yazi" })
vim.keymap.set({ "n", "t" }, "<leader>g", fterm "lazygit", { desc = "open lazygit" })

return fterm
