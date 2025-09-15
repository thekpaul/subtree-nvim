local vimtex = { 'lervag/vimtex' }
vimtex.enabled = false

vimtex.lazy = false
vimtex.init = function()
	vim.g.vimtex_indent_enabled = false
	vim.g.vimtex_view_general_viewer = 'SumatraPDF' -- TODO: Change for other OSes!
	vim.g.vimtex_imaps_enabled = false
 --	vim.g.vimtex_imaps_leader = '@' -- TODO: Check how `imaps` work when enabled!
end

return { vimtex }
