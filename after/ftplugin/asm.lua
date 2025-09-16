if vim.bo.ft ~= 'asm' then
	return
end

-- Local tab/space settings
vim.bo.tabstop = 8
vim.bo.softtabstop = 8
vim.bo.shiftwidth = 8
