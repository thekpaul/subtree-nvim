if vim.bo.ft ~= 'gitcommit' then
	return
end

-- Local tab/space settings
vim.bo.tabstop = 8
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true

-- Coloring columns
vim.opt.colorcolumn = "50,72"
