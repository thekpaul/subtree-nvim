local mini_pairs = { "nvim-mini/mini.pairs" }

mini_pairs.version = false
mini_pairs.enabled = false
mini_pairs.opts = {
	modes = { insert = true, command = true, terminal = false }
}

local autoclose = { "m4xshen/autoclose.nvim" }

autoclose.version = false
autoclose.opts = {
	keys = {
		["("] = { escape = false, close = true, pair = "()" },
		["["] = { escape = false, close = true, pair = "[]" },
		["{"] = { escape = false, close = true, pair = "{}" },

		[">"] = { escape = true, close = false, pair = "<>" },
		[")"] = { escape = true, close = false, pair = "()" },
		["]"] = { escape = true, close = false, pair = "[]" },
		["}"] = { escape = true, close = false, pair = "{}" },

		['"'] = { escape = true, close = true, pair = '""' },
		["'"] = { escape = true, close = true, pair = "''" },
		["`"] = { escape = true, close = true, pair = "``" },
	},
	options = {
		disabled_filetypes = { "text" },
		disable_when_touch = false,
		touch_regex = "[%w(%[{]",
		pair_spaces = true,
		auto_indent = true,
		disable_command_mode = false,
	}
}

local ultimate_autopair = { "altermo/ultimate-autopair.nvim" }

ultimate_autopair.event = {'InsertEnter','CmdlineEnter'}
ultimate_autopair.branch = 'v0.6' -- recommended as each new version will have breaking changes
ultimate_autopair.enabled = false

local auto_pairs = { "jiangmiao/auto-pairs" }

auto_pairs.enabled = false

return { mini_pairs, autoclose, ultimate_autopair, auto_pairs }
