--[=[
THEKPAUL_OPTIONS.lua: Neovim Option Configurations

This module defines keymaps dependent only on Neovim base (internal, native)
options and functionalities.
Options for and/or based on external plugins will be defined in plugin-specific
modules in the `./lua/plugins/` directory.
--]=]

-- Allow local `.nvim.lua`s as a directory-specific configuration
vim.o.exrc = true

-- Virtual edits
vim.o.virtualedit = 'onemore' -- For Consistency in Selective AutoClosing

-- Selection-related options reflecting `mswin`
vim.o.selection  = 'exclusive' -- Exclude last character (cursor position)
vim.opt.selectmode = { 'mouse', 'key' }
vim.opt.keymodel = { 'startsel', 'stopsel' }

-- Mouse usage
vim.o.mouse = 'a'

-- Line numbers
vim.o.number = true

-- Default tab behaviour
vim.o.tabstop     = 4
vim.o.softtabstop = 4
vim.o.shiftwidth  = 4
vim.o.expandtab   = false
vim.o.smarttab    = true
vim.o.autoindent  = true

-- Line wrapping
vim.o.wrap = false
vim.o.sidescroll = 8

-- Fallback options for indentation and line breaks
vim.o.breakindent = true
vim.o.linebreak = true

-- Search case-sensitivity
vim.o.ignorecase = true
vim.o.smartcase = true

-- Current cursor line/column highlighting
vim.o.cursorline   = true
vim.o.cursorcolumn = true

-- Respect 24-bit RGB colors in TUI (favours `gui` values over `cterm`)
vim.o.termguicolors = true

-- Show sign column so that text doesn't shift
vim.o.signcolumn = "auto:3"

-- Coloring columns
vim.opt.colorcolumn = { "80", "120" }

-- Encoding settings
vim.opt.fileencodings = { "ucs-bom", "utf-8", "euc-kr", "default", "latin1" }

-- Add backslash to keyword list
vim.opt.iskeyword:append { '\\' }

-- Split new panes to right & below
vim.o.splitright = true
vim.o.splitbelow = true

-- Fold method
vim.o.foldmethod = "manual"

-- List and list characters
vim.o.list = true
vim.opt.listchars = {
	tab   = " ", -- Other options: , , 󰅂
	trail = "X",
 --	nbsp  = "␣",
 --	eol   = "↲",
}

-- Special settings for list characters in non-modifiable buffers
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if not vim.bo.modifiable then
			vim.opt_local.list = false
		end
	end
})

-- Fill characters: Set `eob` to empty character to remove EOB tildes
vim.opt.fillchars = { eob = " " }

-- Scroll off
vim.o.scrolloff = 10

-- Providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0

-- Default LaTeX flavor
vim.g.tex_flavor = "latex"

-- LEADER key
vim.g.mapleader = " "

-- Additional filetype detection
vim.filetype.add({
	extension = {
		v = 'verilog',
		h = 'c',
		mlx = 'matlabscript'
	},
	pattern = {
		['.*/.*%.cdsinit.*'] = 'skill', -- See `:help lua-patterns`
		['.*ssh/config'] = 'sshconfig',
		['.*/.*%.synopsys_dc.setup.*'] = 'tcl',
		['.*/innovus.cmd.*'] = 'tcl'
	}
})
