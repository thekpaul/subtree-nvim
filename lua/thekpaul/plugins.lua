--[=[
THEKPAUL_PLUGINS.lua: Neovim Plugin Bootstrap Configurations

This module bootstraps the plugin manager and manages user configurations for
designated plugins in the `./lua/plugins` directory.
If no plugin configurations are found, this module produces a warning message
and gracefully returns without terminating or otherwise producing errors.
--]=]

-- Absolute path to plugin configuration modules directory
local plug_abs = vim.fs.abspath(vim.fn.stdpath("config") .. "/lua/plugins")
-- Relative path to plugin configuration modules directory
local plug_rel = vim.fs.relpath(vim.fn.stdpath("config"), plug_abs)

-- Check for plugin configuration files in designated directory
local iter = vim.fs.dir(plug_abs)
if not iter then
	vim.notify("Plugin configurations path ./" .. plug_rel .. "/ is invalid.",
	           vim.log.levels.WARN)
	return
elseif iter() == nil then
	vim.notify("No plugin configurations found in ./" .. plug_rel .. "/",
	           vim.log.levels.WARN)
	return
end

-- Bootstrap LAZY.nvim as a native Lua plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable", -- latest stable release
		lazyrepo,
		lazypath
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	-- LAZY.nvim options
	change_detection = {
		notify = false -- Don't notify when plugin configurations change
	}
})
