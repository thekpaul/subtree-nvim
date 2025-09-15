local barbar = { 'romgrk/barbar.nvim' }

barbar.dependencies = {
	'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
	'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
}
barbar.init = function() vim.g.barbar_auto_setup = false end
barbar.opts = {
	-- Enable/disable animations
	animation = true,

	-- Enable/disable auto-hiding the tab bar when there is a single buffer
	auto_hide = true,

	-- Enable/disable current/total tabpages indicator (top right corner)
	tabpages = true,

	-- Enables/disable clickable tabs
	--  - left-click: go to buffer
	--  - middle-click: delete buffer
	clickable = true,

	-- A buffer to this direction will be focused (if it exists) when closing
	-- the current buffer.
	-- Valid options are 'left' (the default), 'previous', and 'right'
	focus_on_close = 'previous',

	-- Hide inactive buffers and file extensions.
	-- Other options are `alternate`, `current`, and `visible`.
	hide = {extensions = false, inactive = false},

	-- Disable highlighting alternate buffers
	highlight_alternate = false,

	-- Disable highlighting file icons in inactive buffers
	highlight_inactive_file_icons = false,

	-- Enable highlighting visible buffers
	highlight_visible = true,

	icons = {
		-- Configure the base icons on the bufferline.
		-- Valid options to display the buffer index and number are
		-- `true`, 'superscript' and 'subscript'
		buffer_index = true,
		buffer_number = false,
		button = '×',
		-- Enables / disables diagnostic symbols
		diagnostics = {
			[vim.diagnostic.severity.ERROR] = {enabled = true,  icon = ' '},
			[vim.diagnostic.severity.WARN]  = {enabled = false, icon = ' '},
			[vim.diagnostic.severity.INFO]  = {enabled = false, icon = '󰠠 '},
			[vim.diagnostic.severity.HINT]  = {enabled = true,  icon = ' '},
		},
		gitsigns = {
			added   = {enabled = true, icon = '+'},
			changed = {enabled = true, icon = '~'},
			deleted = {enabled = true, icon = '-'},
		},
		filetype = {
			-- Sets the icon's highlight group.
			-- If false, will use nvim-web-devicons colors
			custom_colors = false,

			-- Requires `nvim-web-devicons` if `true`
			enabled = true,
		},
		separator = {left = '|', right = ''},

		-- Configure the icons on the bufferline when modified or pinned.
		-- Supports all the base icon options.
		modified = {button = '●'},
		pinned = {button = '', filename = true},

		-- Use a preconfigured buffer appearance,
		-- can be 'default', 'powerline', or 'slanted'
		preset = 'default',

		-- Configure the icons on the bufferline based on visibility.
		-- Supports all the base icon options, plus `modified` and `pinned`.
		alternate = {filetype = {enabled = false}},
		current   = {buffer_index = true},
		inactive  = {button = '×'},
		visible   = {modified = {buffer_number = false}},
	},

	-- If true, new buffers will be inserted at the start/end of the list.
	-- Default is to insert after current buffer.
	insert_at_end = false,
	insert_at_start = false,

	-- Sets the maximum padding width with which to surround each tab
	maximum_padding = 1,

	-- Sets the minimum padding width with which to surround each tab
	minimum_padding = 1,

	-- Sets the maximum buffer name length.
	maximum_length = 30,

	-- Sets the minimum buffer name length.
	minimum_length = 0,

	-- If set, the letters for each buffer in buffer-pick mode will be
	-- assigned based on their name. Otherwise or in case all letters are
	-- already assigned, the behavior is to assign letters in order of
	-- usability (see order below)
	semantic_letters = true,

	-- Set the filetypes which barbar will offset itself for
	sidebar_filetypes = {
		-- Use the default values: {event = 'BufWinLeave', text = nil}
		NvimTree = true,
		-- Or, specify the text used for the offset:
		undotree = {text = 'undotree'},
		-- Or, specify the event which the sidebar executes when leaving:
		['neo-tree'] = {event = 'BufWipeout'},
		-- Or, specify both
		Outline = {event = 'BufWinLeave', text = 'symbols-outline'},
	},

	-- New buffer letters are assigned in this order. This order is
	-- optimal for the qwerty keyboard layout but might need adjustment
	-- for other layouts.
	letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

	-- Sets the name of unnamed buffers.
	-- By default format is "[Buffer X]" where X is the buffer number.
	-- But only a static string is accepted here.
	no_name_title = nil
}
barbar.config = function(_, opts)
	require("barbar").setup(opts)

	-- Temporary custom highlight groups
	local BufferDefaultTabpages = vim.api.nvim_get_hl(0, {
		name = "BufferDefaultTabpages"
	})
	local BufferTabpages = vim.tbl_extend('force', {},
		BufferDefaultTabpages, { bg = '#565656' }
	)
	vim.api.nvim_set_hl(0, "BufferTabpages", BufferTabpages)

	local BufferDefaultTabpageFill = vim.api.nvim_get_hl(0, {
		name = "BufferDefaultTabpageFill"
	})
	local BufferTabpageFill = vim.tbl_extend('force', {},
		BufferDefaultTabpageFill, { bg = '#565656' }
	)
	vim.api.nvim_set_hl(0, "BufferTabpageFill", BufferTabpageFill)

	local BufferDefaultTabpagesSep = vim.api.nvim_get_hl(0, {
		name = "BufferDefaultTabpagesSep"
	})
	local BufferTabpagesSep = vim.tbl_extend('force', {},
		BufferDefaultTabpagesSep, { bg = '#565656', fg = '#ffffff' }
	)
	vim.api.nvim_set_hl(0, "BufferTabpagesSep", BufferTabpagesSep)

	-- Mappings for the `romgrk/barbar.nvim` Plugin.
	local map = vim.keymap.set
	local mapopts = { remap = false, silent = true }

	mapopts.desc = "Go to previous buffer"
	map("n", ",,", '<CMD>BufferPrevious<CR>', mapopts)

	mapopts.desc = "Go to next buffer"
	map("n", ",.", '<CMD>BufferNext<CR>', mapopts)

	mapopts.desc = "Move current buffer to previous position"
	map("n", ",<", '<CMD>BufferMovePrevious<CR>', mapopts)

	mapopts.desc = "Move current buffer to next position"
	map("n", ",>", '<CMD>BufferMoveNext<CR>', mapopts)

	mapopts.desc = "Go to buffer 1"
	map("n", ",1", '<CMD>BufferGoto 1<CR>', mapopts)

	mapopts.desc = "Go to buffer 2"
	map("n", ",2", '<CMD>BufferGoto 2<CR>', mapopts)

	mapopts.desc = "Go to buffer 3"
	map("n", ",3", '<CMD>BufferGoto 3<CR>', mapopts)

	mapopts.desc = "Go to buffer 4"
	map("n", ",4", '<CMD>BufferGoto 4<CR>', mapopts)

	mapopts.desc = "Go to buffer 5"
	map("n", ",5", '<CMD>BufferGoto 5<CR>', mapopts)

	mapopts.desc = "Go to buffer 6"
	map("n", ",6", '<CMD>BufferGoto 6<CR>', mapopts)

	mapopts.desc = "Go to buffer 7"
	map("n", ",7", '<CMD>BufferGoto 7<CR>', mapopts)

	mapopts.desc = "Go to buffer 8"
	map("n", ",8", '<CMD>BufferGoto 8<CR>', mapopts)

	mapopts.desc = "Go to last buffer"
	map("n", ",9", '<CMD>BufferLast<CR>', mapopts)

	mapopts.desc = "Pin current buffer"
	map("n", ",p", '<CMD>BufferPin<CR>', mapopts)

	mapopts.desc = "Close current buffer"
	map("n", ",c", '<CMD>BufferClose<CR>', mapopts)

	mapopts.desc = "Automatic buffer sort: Buffer number"
	map("n", ",bb", '<CMD>BufferOrderByBufferNumber<CR>', mapopts)

	mapopts.desc = "Automatic buffer sort: Directory"
	map("n", ",bd", '<CMD>BufferOrderByDirectory<CR>', mapopts)

	mapopts.desc = "Automatic buffer sort: Language"
	map("n", ",bl", '<CMD>BufferOrderByLanguage<CR>', mapopts)

	mapopts.desc = "Automatic buffer sort: Window number"
	map("n", ",bw", '<CMD>BufferOrderByWindowNumber<CR>', mapopts)
end

local airline = { 'vim-airline/vim-airline' }

airline.init = function()
	vim.g.airline_powerline_fonts = true
end

return { barbar, airline }
