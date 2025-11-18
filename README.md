Neovim Subtree
===

This subtree tracks configurations for the `nvim` Neovim executable.

## Branch README

This branch filters configurations and plugins for Neovim that can be used
without conflict in Visual Studio Code via the [VSCode-Neovim][vscode-nvim]
plugin.

## Installation

Install this subtree at `$XDG_CONFIG_HOME/nvim`:

1. **(Recommended)** Use git-worktree from your local DOTS installation:
   ```sh
   git worktree add $XDG_CONFIG_HOME/nvim -b subtree-nvim --track <remote_name>/subtree-nvim
   ```
   where `remote_name` is the name of the "remote" repository from which your
   DOTS installation is cloned.

2. Standalone installation from remote
   ```sh
   git clone https://github.com/thekpaul/DOTS.git $XDG_CONFIG_HOME/nvim -b subtree-nvim
   ```

3. (_NOT_ recommended) (Sym)link from your local DOTS installation:
   This will render all future modifications to be commited _directly_ to the
   `main` branch instead of the `subtree-nvim` branch.
   - Unix-based systems where `ln` is available:
     ```sh
     ln (-s) <DOTS_INSTALLATION_PATH>/nvim $XDG_CONFIG_HOME/nvim
     ```
   - Windows systems with PowerShell, using the `New-Item` cmdlet:
     ```pwsh
     New-Item -Path $env:XDG_CONFIG_HOME\nvim -ItemType SymbolicLink -Value <DOTS_INSTALLATION_PATH>\nvim
     ```
   Make sure to use the _full path_ for `<DOTS_INSTALLATION_PATH>`.

## Meta

Authored and maintained by [Paul Kim](https://thekpaul.dev).

Distributed under the [MIT License][license].

[license]: ./LICENSE.md
[vscode-nvim]: https://github.com/vscode-neovim/vscode-neovim
