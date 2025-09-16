if vim.bo.ft ~= 'fish' then
	return
end

-- Local tab/space settings
vim.bo.tabstop = 8
vim.bo.expandtab = true
