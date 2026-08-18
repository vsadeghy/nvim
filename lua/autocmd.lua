vim.api.nvim_create_autocmd("FileType", {
	pattern = "man",
	callback = function()
		Map("n", "d", "<C-d>", { nowait = true })
		Map("n", "u", "<C-u>", { nowait = true })
	end,
})
vim.api.nvim_create_autocmd("TermOpen", { command = "startinsert" })
vim.api.nvim_create_autocmd("BufReadPost", { command = 'norm! `"zz' })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function() vim.highlight.on_yank { timeout = 150 } end,
})
vim.api.nvim_create_autocmd("FileType", {
	callback = function() vim.opt.formatoptions:remove { "c", "r", "o" } end,
})
-- close [No Name] buffers
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_get_name(bufnr) == "" then
				local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
				if #lines == 1 and lines[1] == "" then vim.api.nvim_buf_delete(bufnr, { force = true }) end
			end
		end
	end,
})
