local todo_comments = { "folke/todo-comments.nvim" }

todo_comments.dependencies = { "nvim-lua/plenary.nvim" }
todo_comments.cmd = { "TodoTelescope", "TodoQuickFix" }
todo_comments.opts = {
	keywords = {
		FIX = {
			icon = " ",
			color = "error",
			alt = { "FIXME", "BUG", "ERR", "ERROR", "ISSUE" }
		},
		TODO = {
			icon = " ",
			color = "hint",
			alt = { "DO" }
		},
		HACK = {
			icon = " ",
			color = "warning"
		},
		WARN = {
			icon = " ",
			color = "warning",
			alt = { "WARNING" }
		},
		PERF = {
			icon = " ",
			color = "perf",
			alt = { "OPT", "PERFORMANCE", "OPTIMIZE" }
		},
		NOTE = {
			icon = " ",
			color = "info",
			alt = { "INFO" }
		},
		TEST = {
			icon = "⏲ ",
			color = "test",
			alt = { "TESTING", "PASSED", "FAILED" }
		}
	},
	colors = {
		perf = { "DiagnosticOk", "#B3F6C0" }
	}
}
todo_comments.keys = {
	{
		"<leader>tn", function ()
			require("todo-comments").jump_next()
		end, desc = "Next todo comment"
	},
	{
		"<leader>tp", function ()
			require("todo-comments").jump_prev()
		end, desc = "Previous todo comment"
	},
	{ -- TODO: Ensure `telescope.nvim` is loaded before enabling this keymap
		"<leader>ft", '<CMD>TodoTelescope<CR>',
		desc = "[F]ind [T]odo Comments (from todo-comments.nvim)"
	}
}

return { todo_comments }
