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

