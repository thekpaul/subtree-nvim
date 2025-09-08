local oil = { 'stevearc/oil.nvim' }

oil.dependencies = {
	"nvim-tree/nvim-web-devicons"
--	"echasnovski/mini.icons" -- NOTE: Alternative icons provider dependency
}
oil.opts = {
	columns = { -- :help oil-columns
		"permissions",
		"size",
		{ "mtime", format = "%y/%m/%d %H:%M" },
		"icon"
	},
	delete_to_trash = true, -- :help oil-trash
}

local telescope = { "nvim-telescope/telescope.nvim" }

local telescope_fzf_build = function(plugin)
	local throw_err = function(cmd)
		if cmd.code ~= 0 then error(cmd.stderr) end
	end
	if vim.uv.os_uname().sysname == "Windows_NT" then
		local cmd = vim.system({
			'cmake', '-S.', '-Bbuild', '-DCMAKE_BUILD_TYPE=Release',
			-- Upstream problems with CMake minimum version
			'-DCMAKE_POLICY_VERSION_MINIMUM=3.5',
			'-G', 'Visual Studio 17 2022'
		}, { cwd = plugin.dir }):wait()
		if cmd.code ~= 0 then
			cmd = vim.system({
				-- Use shell-agnostic `git` to clear failed build output
				'git', 'clean', '-Xfd'
			}, { cwd = plugin.dir }):wait()
			if cmd.code ~= 0 then
				error(
					cmd.stderr
					.. "Failed to clean previous build from Visual Studio."
				)
			end
			cmd = vim.system({
				'cmake', '-S.', '-Bbuild', '-DCMAKE_BUILD_TYPE=Release',
				-- Upstream problems with CMake minimum version
				'-DCMAKE_POLICY_VERSION_MINIMUM=3.5',
				'-G', 'MinGW Makefiles'
			}, { cwd = plugin.dir }):wait()
			if cmd.code ~= 0 then
				error(
					cmd.stderr
					.. "CMake cannot find a usable generator.\n"
					.. "Please install either Visual Studio 2022 or MinGW."
				)
			end
		end
		cmd = vim.system({
			'cmake', '--build', 'build', '--config', 'Release'
		}, { cwd = plugin.dir }):wait()
		throw_err(cmd)
		cmd = vim.system({
			'cmake', '--install', 'build', '--prefix', 'build'
		}, { cwd = plugin.dir }):wait()
		throw_err(cmd)
	else
		local cmd = vim.system({ 'make' }, { cwd = plugin.dir }):wait()
		throw_err(cmd)
	end
end

telescope.branch = "0.1.x"
telescope.dependencies = {
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	{ -- `telescope.nvim`-specific add-on plugin for native FZF functionality
		"nvim-telescope/telescope-fzf-native.nvim",
		build = telescope_fzf_build
	}
}
telescope.config = function()
	local req_telescope = require("telescope")
	local req_actions = require("telescope.actions")
	local req_builtin = require("telescope.builtin")

	req_telescope.setup({
		defaults = {
			path_display = { "smart" },
			mappings = {
				i = {
					["<C-k>"] = req_actions.move_selection_previous,
					["<C-j>"] = req_actions.move_selection_next,
					["<C-q>"] = req_actions.send_selected_to_qflist + req_actions.open_qflist,
				},
				n = {
					["dd"] = require("telescope.actions").delete_buffer,
					["q"] = require("telescope.actions").close
				}
			}
		}
	})

	req_telescope.load_extension("fzf")

	local map = vim.keymap.set

	map("n", "<leader>ff", req_builtin.find_files,
		{ desc = "[F]uzzy find [f]iles in Neovim's PWD" }
	)
	map("n", "<leader>fg", req_builtin.git_files,
		{ desc = "[F]uzzy find files with [G]it" }
	)
	map("n", "<leader>fh", req_builtin.oldfiles,
		{ desc = "[F]uzzy find from files in [h]istory" }
	)
	map("n", "<leader>fs", req_builtin.live_grep,
		{ desc = "[F]ind [s]tring in Neovim's PWD" }
	)
	map("n", "<leader>fc", req_builtin.grep_string,
		{ desc = "[F]ind string under [c]ursor in PWD" }
	)
	map("n", "<leader>fb", function()
			req_builtin.buffers({
				sort_mru = true,
				sort_lastused = true,
				initial_mode = "normal"
			})
		end,
		{ desc = "[F]ind [b]uffer in current Neovim session" }
	)
end

return { oil, telescope }
