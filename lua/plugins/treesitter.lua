local treesitter = { 'nvim-treesitter/nvim-treesitter' }

treesitter.build = ":TSUpdate"
treesitter.main = "nvim-treesitter.configs"
treesitter.opts = {
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = {
		"c", "lua", "vim", "vimdoc", "query", -- Necessary
		"cpp", "git_rebase", "gitcommit", "gitignore" -- Optionals
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- (may require `tree-sitter` CLI for e.g. `latex`)
	auto_install = true,

	-- List of parsers to ignore installing (or "all")
	ignore_install = { "javascript", "latex" },

	highlight = {
		enable = true,
		disable = { "latex" },

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	}
}

return { treesitter }
