--[=[
INIT.lua: Configuration Entry Point for Neovim in Lua
--]=]

require("thekpaul.options")
require("thekpaul.keymaps")
if not vim.g.vscode then
	require("thekpaul.plugins")
end
