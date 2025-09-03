local colorscheme_defaults = {
	lazy = false,
	priority = 1000
}

--- Show comments as ITALIC (works well with cursive fonts)
---   -> Apply AFTER colorscheme!
local function comment_italic()
	local oldComment = vim.api.nvim_get_hl(0, { name = "Comment" })
	local newComment = vim.tbl_extend('force', oldComment, { italic = true })
	vim.api.nvim_set_hl(0, "Comment", newComment)
end

local seoul256 = vim.tbl_extend('force', colorscheme_defaults, {
	'junegunn/seoul256.vim'
})

seoul256.config = function ()
	vim.g.seoul256_background = 234
	vim.cmd.colorscheme 'seoul256'
	comment_italic()
end

return { seoul256 }
