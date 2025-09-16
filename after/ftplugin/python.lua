if vim.bo.ft ~= 'python' then
	return
end

-- Local tab/space settings
vim.bo.tabstop = 8
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true
