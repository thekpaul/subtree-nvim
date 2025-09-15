local gitsigns = { 'lewis6991/gitsigns.nvim' }

--- Callback function for buffer-specific keymaps
--- @param bufnr integer
local function keymap_callback(bufnr)
	local fn = require('gitsigns')

	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	-- Baseline Table for Options
	local mapopts = { buffer = bufnr, --[[silent = true]] }

	-- Navigation
	mapopts.desc = "Move Cursor to [N]ext Git Change"
	map('n', '<leader>gn', function()
		fn.nav_hunk('next')
	end, mapopts)

	mapopts.desc = "Move Cursor to [P]revious Git Change"
	map('n', '<leader>gp', function()
		fn.nav_hunk('prev')
	end, mapopts)

	-- Actions
	mapopts.desc = "[S]tage Hunk at Current Cursor Position"
	map('n', '<leader>gs', fn.stage_hunk, mapopts)

	mapopts.desc = "[R]eset Hunk at Current Cursor Position"
	map('n', '<leader>gr', fn.reset_hunk, mapopts)

	mapopts.desc = "[S]tage Hunk in Selected Lines"
	map('v', '<leader>gs', function()
		fn.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
	end, mapopts)

	mapopts.desc = "[R]eset Hunk in Selected Lines"
	map('v', '<leader>gr', function()
		fn.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
	end, mapopts)

	mapopts.desc = "[S]tage ALL Hunks in Current Buffer"
	map('n', '<leader>gS', fn.stage_buffer, mapopts)

	mapopts.desc = "[U]ndo LAST CALL of Stage Hunk"
	map('n', '<leader>gu', fn.undo_stage_hunk, mapopts)

	mapopts.desc = "[R]eset ALL Hunk Lines in Buffer"
	map('n', '<leader>gR', fn.reset_buffer, mapopts)

	mapopts.desc = "Pre[v]iew Hunk at Current Cursor Position (Floating)"
	map('n', '<leader>gv', fn.preview_hunk, mapopts)

	mapopts.desc = "Show Current Line `git [b]lame` Results (Floating)"
	map('n', '<leader>gb', function()
		fn.blame_line({ full = true })
	end, mapopts)

	mapopts.desc = "[T]oggle Current Line [B]lame"
	map('n', '<leader>gtb', fn.toggle_current_line_blame, mapopts)

	mapopts.desc = "Open VIM[D]IFF for Current Buffer Against INDEX"
	map('n', '<leader>gd', fn.diffthis, mapopts)

	mapopts.desc = "Open VIM[D]IFF for Current Buffer Against HEAD"
	map('n', '<leader>gD', function()
		fn.diffthis('~')
	end, mapopts)

	mapopts.desc = "[T]oggle View Modifications and [D]eletions"
	map('n', '<leader>gtd', fn.toggle_deleted, mapopts)

	mapopts.desc = "Select Hunk at Current Cursor"
	map({'o', 'x'}, 'ih', fn.select_hunk, mapopts)
end

gitsigns.opts = {
	on_attach = keymap_callback
}

local fugitive = { url = 'https://tpope.io/vim/fugitive.git' }

return { gitsigns, fugitive }
