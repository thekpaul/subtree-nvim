Neovim Plugins
===

This subdirectory houses configurations for Neovim plugins conforming to the
[Lazy.nvim] plugin manager, organised into files per category.
Each file contains configurations for one or more plugins, with each plugin
being configured in its own `local` table.
The files will return a single table that contains one or more of such `local`
configuration tables.

A simple overview is listed below:

- Colorscheme: [`./colorscheme.lua`](./colorscheme.lua)
  - [`junegunn/seoul256.vim`](https://github.com/junegunn/seoul256.vim)

[Lazy.nvim]: https://github.com/folke/lazy.nvim
