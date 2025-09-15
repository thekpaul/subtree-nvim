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
- Finder: [`./finder.lua`](./finder.lua)
  - [`stevearc/oil.nvim`](https://github.com/stevearc/oil.nvim)
  - [`nvim-telescope/telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim)
    - [`nvim-telescope/telescope-fzf-native.nvim`](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
- Treesitter: [`./treesitter.lua`](./treesitter.lua)
  - [`nvim-treesitter/nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter)
- LSP: [`./lsp.lua`](./lsp.lua)
  - [`neovim/nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig)
    - [`hrsh7th/cmp-nvim-lsp`](https://github.com/hrsh7th/cmp-nvim-lsp)
  - [`mason-org/mason.nvim`](https://github.com/mason-org/mason.nvim)
  - [`mason-org/mason-lspconfig.nvim`](https://github.com/mason-org/mason-lspconfig.nvim)
- Completion engine: [`./completion.lua`](./completion.lua)
  - [`hrsh7th/nvim-cmp`](https://github.com/hrsh7th/nvim-cmp)
    - [`hrsh7th/cmp-buffer`](https://github.com/hrsh7th/cmp-buffer)
    - [`hrsh7th/cmp-path`](https://github.com/hrsh7th/cmp-path)
    - [`saadparwaiz1/cmp_luasnip`](https://github.com/saadparwaiz1/cmp_luasnip)
    - [`rafamadriz/friendly-snippets`](https://github.com/rafamadriz/friendly-snippets)
  - [`L3MON4D3/LuaSnip`](https://github.com/L3MON4D3/LuaSnip)
- Statusline: [`./statusline.lua`](./statusline.lua)
  - [`romgrk/barbar.nvim`](https://github.com/romgrk/barbar.nvim)
  - [`vim-airline/vim-airline`](https://github.com/vim-airline/vim-airline)
- Git integration: [`./git.lua`](./git.lua)
  - [`lewis6991/gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim)
  - [`tpope/vim-fugitive`](https://github.com/tpope/vim-fugitive)
- Indentation assistance: [`./indent.lua`](./indent.lua)
  - [`lukas-reineke/indent-blankline.nvim`](https://github.com/lukas-reineke/indent-blankline.nvim)
- Keymap assistance: [`./keymaps.lua`](./keymaps.lua)
  - [`folke/which-key.nvim`](https://github.com/folke/which-key.nvim)
- Auto-pairing: [`./pairs.lua`](./pairs.lua)
  - [`nvim-mini/mini.pairs`](https://github.com/nvim-mini/mini.pairs)
  - [`m4xshen/autoclose.nvim`](https://github.com/m4xshen/autoclose.nvim)
  - [`altermo/ultimate-autopair.nvim`](https://github.com/altermo/ultimate-autopair.nvim)
  - [`jiangmiao/auto-pairs`](https://github.com/jiangmiao/auto-pairs)

[Lazy.nvim]: https://github.com/folke/lazy.nvim
