local ibl = { "lukas-reineke/indent-blankline.nvim" }

ibl.main = "ibl"
ibl.opts = {
	indent = {
		char = "▏",
		tab_char = "▏",
		highlight = { "NonText" }
	},
	whitespace = {
		remove_blankline_trail = false,
		highlight = { "IndentOdd", "IndentEven" }
	},
	scope = {
		highlight = "ScopeFG"
	},
}
ibl.config = function(_, opts)
	-- Indentation whitespace highlight groups
	vim.api.nvim_set_hl(0, "IndentOdd", { -- Odd  level
		ctermbg = 233, bg = "#181818"
	})
	vim.api.nvim_set_hl(0, "IndentEven", { -- Even level
		ctermbg = 235, bg = "#303030"
	})
	vim.api.nvim_set_hl(0, "ScopeFG", { -- Scope Foregrounds
		ctermfg = 101, fg = "#999872"
	})

	require("ibl").setup(opts)

	-- Automatically enable-disable when in visual mode
	-- Source: https://github.com/lukas-reineke/indent-blankline.nvim/issues/132#issuecomment-1893103850
	local indent_blankline_augroup = vim.api.nvim_create_augroup(
		"indent_blankline_augroup", {
			clear = true
		}
	)
	vim.api.nvim_create_autocmd("ModeChanged", {
	    group = indent_blankline_augroup,
	    pattern = { "[vV\x16]*:*" },
	    command = "IBLEnable",
	    desc = "Enable indent-blankline when exiting visual or selection mode"
	})

	vim.api.nvim_create_autocmd("ModeChanged", {
	    group = indent_blankline_augroup,
	    pattern = { "*:[vV\x16]*" },
	    command = "IBLDisable",
	    desc = "Disable indent-blankline when entering visual or selection mode"
	})
end

return { ibl }
