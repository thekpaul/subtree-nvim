--[=[
THEKPAUL_KEYMAPS.lua: Neovim Key Map Configurations

This module defines keymaps dependent only on Neovim base (internal, native)
keymaps and functionalities.
Keymaps for and/or based on external plugins will be defined in plugin-specific
modules in the `./lua/plugins/` directory.

Keymap definitions use the local alias `map` as an alias for `vim.keymap.set`,
with a local table `mapopts` that is overwritten before defining each keymap.
The `mapopts.desc` field is set before defining ALL keymaps and serves as both
the description registered for each keymap AND the explanatory comment for the
defined keymap.

Related keymaps will be contiguously defined and grouped in commented-out
braces (`--{`, `--}`) to enhance file readability.
--]=]

-- Global mappings
local map = vim.keymap.set
local mapopts = { remap = false }

-- Save Without Trailing Whitespaces
-- {
local function save_without_trailing_whitespaces()
	local cursor = vim.api.nvim_win_get_cursor(0)
	vim.cmd('keeppatterns %s/\\s\\+$//e')
	vim.cmd.update()
	vim.api.nvim_win_set_cursor(0, cursor)
end

mapopts.desc = "Save Without Trailing Whitespaces"
map({ "n", "i" }, "<C-s>", save_without_trailing_whitespaces, mapopts)
-- }

-- Line-wise Move
-- {
mapopts.desc = "Move Current Line Down 1 Line"
map("n", "<M-j>", ":move +1<CR>", mapopts)

mapopts.desc = "Move Current Line Up 1 Line"
map("n", "<M-k>", ":move -2<CR>", mapopts)

mapopts.desc = "Move Selection Down 1 Line"
map("v", "J", ":move '>+1<CR>gv=gv", mapopts)

mapopts.desc = "Move Selection Up 1 Line"
map("v", "K", ":move '<-2<CR>gv=gv", mapopts)
-- }

-- Keep cursor vertically centered during page-jumping and search
-- {
mapopts.desc = "[VCC] Half-page Down"
map("n", "<C-d>", "<C-d>zz")

mapopts.desc = "[VCC] Half-page Up"
map("n", "<C-u>", "<C-u>zz")

mapopts.desc = "[VCC] Full-page Down"
map("n", "<C-f>", "<C-f>zz")

mapopts.desc = "[VCC] Full-page Up"
map("n", "<C-b>", "<C-b>zz")

mapopts.desc = "[VCC] Find Next Search"
map("n", "n", "nzzzv")

mapopts.desc = "[VCC] Find Previous Search"
map("n", "N", "Nzzzv")
-- }

-- Paste or delete without overwriting local clipboard
-- {
mapopts.desc = "Paste to Selection without Overwriting Buffer"
map("x", "<leader>p", "\"_dP")

mapopts.desc = "Delete without Overwriting Buffer"
map({ "n", "v" }, "<leader>d", "\"_d")

mapopts.desc = "Delete until EOL without Overwriting Buffer"
map("n", "<leader>D", "\"_D")

mapopts.desc = "Delete Selected Lines without Overwriting Buffer"
map("v", "<leader>D", "\"_D")

mapopts.desc = "Change without Overwriting Buffer"
map({"n", "v"}, "<leader>c", "\"_c")

mapopts.desc = "Change until EOL without Overwriting Buffer"
map("n", "<leader>C", "\"_C")

mapopts.desc = "Change Selected Lines without Overwriting Buffer"
map("v", "<leader>C", "\"_C")
-- }

-- Easy access to system clipboard
-- {
mapopts.desc = "Yank to System Clipboard"
map({ "n", "v" }, "<leader>y", "\"+y")

mapopts.desc = "Yank Current Line to System Clipboard"
map("n", "<leader>Y", "\"+Y")
-- }

mapopts.desc = "Return to Normal Mode in Terminal Buffer"
map("t", "<Esc>", "<C-\\><C-n>")

mapopts.desc = "Keep Cursor in Place While Joining Lines"
map("n", "<leader>J", "mzJ`z")
