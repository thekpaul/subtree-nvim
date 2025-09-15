--- Determine `vim.lsp` API availability based on current Nvim version (v0.11)
--- @type boolean
local lsp_api_0p11 = vim.version.ge(vim.version(), '0.11.0')

--- Determine necessary plugin versions based on `vim.lsp` API availability
--- @return { lspconfig: string, mason: string }
local function lsp_api_versions()
	if lsp_api_0p11 then
		return { lspconfig = "*",     mason = "2.*" }
	else
		return { lspconfig = "2.0.*", mason = "1.*" }
	end
end

local nvim_lspconfig = { "neovim/nvim-lspconfig" }

nvim_lspconfig.version = lsp_api_versions().lspconfig
nvim_lspconfig.dependencies = {
	"hrsh7th/cmp-nvim-lsp",
	"nvim-telescope/telescope.nvim"
}

--- Callback function to enable keymaps per buffer when LSP is attached
--- @param ev {
---     id: integer, event: string, group: integer|nil, match: string,
---     buf: integer, file: string, data: any,
--- }
local function lspconfig_keymaps(ev)
	local tele_builtin = require("telescope.builtin")
	local map = vim.keymap.set

	-- Buffer local mappings: See `:h vim.lsp.*` for docs
	local opts = { buffer = ev.buf, silent = true }

	-- Override Global Keymaps for Similar Functionalities {
	opts.desc = "Show LSP [D]efinitions with Telescope"
	map("n", "gd", tele_builtin.lsp_definitions, opts)

	opts.desc = "[G]o to [D]eclaration"
	map("n", "gD", vim.lsp.buf.declaration, opts)

	opts.desc = "Show Documentation for What is Under Cursor [K]"
	map("n", "K", vim.lsp.buf.hover, opts)
	-- }

	-- Telescope Integrations (Lower-cases for All Mappings) {
	opts.desc = "Show LSP [R]eferences with Telescope"
	map("n", "<leader>lr", tele_builtin.lsp_references, opts)

	opts.desc = "Show LSP [I]mplementations with Telescope"
	map("n", "<leader>li", tele_builtin.lsp_implementations, opts)

	opts.desc = "Show LSP [T]ype Definitions"
	map("n", "<leader>lt", tele_builtin.lsp_type_definitions, opts)

	opts.desc = "Show Current [B]uffer Diagnostics"
	map("n", "<leader>lB", function()
		tele_builtin.diagnostics({ bufnr = 0 })
	end, opts)
	-- }

	opts.desc = "See Available Code [A]ctions"
	map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)

	opts.desc = "Smart [R]e[n]ame"
	map("n", "<leader>rn", vim.lsp.buf.rename, opts)

	opts.desc = "Show [L]ine Diagnostics"
	map("n", "<leader>ll", vim.diagnostic.open_float, opts)

	if lsp_api_0p11 then
		opts.desc = "Go to [P]revious Diagnostic"
		map("n", "<leader>lp", function ()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)

		opts.desc = "Go to [N]ext Diagnostic"
		map("n", "<leader>ln", function ()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)
	else
		opts.desc = "Go to [P]revious Diagnostic"
		map("n", "<leader>lp", vim.diagnostic.goto_prev, opts)

		opts.desc = "Go to [N]ext Diagnostic"
		map("n", "<leader>lp", vim.diagnostic.goto_next, opts)
	end

	opts.desc = "Explicitly [R]e[s]tart LSP"
	map("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
end

--- Pre-v0.11 setup using mason-lspconfig.nvim's `.setup_handlers()` function
--- This is deprecated functionality and is kept for Nvim v0.10.x
--- Requires lspconfig.nvim < v2.1 and Mason(-lspconfig).nvim v1.x
local function lspconfig_pre_0p11()
	if lsp_api_0p11 then
		return
	end

	-- Enable Autocompletion (Assign to EVERY LSP Server Configuration)
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local lspconfig = require("lspconfig")

	-- Handlers used in `mason-lspconfig.nvim` to set up LSP servers
	-- See `:h mason-lspconfig.setup_handlers()` for docs
	require("mason-lspconfig").setup_handlers({
		-- First entry as the default, fallback handler
		function(server_name)
			lspconfig[server_name].setup({
				capabilities = capabilities
			})
		end,
		["lua_ls"] = function() -- configure lua server (with special settings)
			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				-- Provided by `lua_ls` documentation for primary use in Neovim
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if vim.uv.fs_stat(path..'/.luarc.json')
							or vim.uv.fs_stat(path..'/.luarc.jsonc') then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend(
						'force', client.config.settings.Lua, {
							runtime = {
								-- Tell the language server which version of Lua you're using
								-- (most likely LuaJIT in the case of Neovim)
								version = 'LuaJIT'
							},
							-- Make the server aware of Neovim runtime files
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME,
									"${3rd}/luv/library" -- `luv` lib for Neovim
								}
							}
						}
					)
				end,
				settings = {
					Lua = { -- make the language server recognize "vim" global
						diagnostics = {
							globals = { "vim" }
						},
						completion = {
							callSnippet = "Replace"
						}
					}
				}
			})
		end,
		["verible"] = function()
			lspconfig["verible"].setup({
				capabilities = capabilities,
				cmd = { 'verible-verilog-ls', '--rules_config_search' },
				root_dir = function(fname)
					return
						vim.fs.dirname(vim.fs.find(
							'.rules.verible_lint', -- local Verible lint rule
							{ path = fname, upward = true }
						)[1]) or
						vim.fs.dirname(vim.fs.find(
							'.git', -- local Git repository, second option
							{ path = fname, upward = true }
						)[1]) or
						vim.fn.getcwd() -- current directory (for single-file system), fallback
				end
			})
		end
	})

	-- Setup functions for non-`mason` language servers
	-- These may depend on external binaries available on the system,
	-- and may cause issues when such dependencies are not available.
	lspconfig.nushell.setup{} -- Requires an external Nushell binary
end

local function lspconfig_post_0p11()
	if not lsp_api_0p11 then
		return
	end
	-- Enable Autocompletion (Assign to EVERY LSP Server Configuration)
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	vim.lsp.config('*', { capabilities = capabilities })

	-- Configurations for `mason`-managed language servers
	-- Since `mason-lspconfig` automatically enables installed language servers,
	-- all that is needed at this time are overriding configurations, if any.

	-- Lua LSP `lua_ls`: Managed via Mason.nvim
	vim.lsp.config('lua_ls', {
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if path ~= vim.fn.stdpath('config') and (
					vim.uv.fs_stat(path .. '/.luarc.json') or
					vim.uv.fs_stat(path .. '/.luarc.jsonc')
				) then
					return
				end
			end

			client.config.settings.Lua = vim.tbl_deep_extend(
				'force', client.config.settings.Lua, {
					runtime = {
						version = 'LuaJIT',
						path = { 'lua/?.lua', 'lua/?/init.lua', },
					},
					workspace = {
						checkThirdParty = false,
						library = { vim.env.VIMRUNTIME, '${3rd}/luv/library' }
					}
				}
			)
		end,
		settings = {
			Lua = {}
		}
	})

	-- (System)Verilog LSP `verible`: Managed via Mason.nvim
	vim.lsp.config('verible', {
		cmd = { 'verible-verilog-ls', '--rules_config_search' },
	})

	-- Configurations for non-`mason` language servers
	-- Language servers not managed by `mason` must be located, configured and
	-- enabled manually.
	-- For language servers found on `$PATH`, explicit location is not required.

	-- Nushell LSP: built-in to Nushell binary
	-- Note that the Nushell binary must be installed on system and
	-- able to be found by Neovim for the Nushell LSP to function correctly.
	vim.lsp.enable('nushell')
end

nvim_lspconfig.config = function()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = lspconfig_keymaps
	})

	-- Setup LSP diagnostic symbols in sign column (gutter)
	local signs = { Error = " ", Warn = " ", Info = " ", Hint = "󰠠 " }
	if lsp_api_0p11 then
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = signs.Error,
					[vim.diagnostic.severity.WARN]  = signs.Warn,
					[vim.diagnostic.severity.INFO]  = signs.Info,
					[vim.diagnostic.severity.HINT]  = signs.Hint
				},
				texthl = {
					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
					[vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
					[vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
					[vim.diagnostic.severity.HINT]  = "DiagnosticSignHint"
				}
			}
		})
	else
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
	end

	-- Configure LSPs based on `vim.lsp` API availability with `lsp_api_0p11`
	if lsp_api_0p11 then
		lspconfig_post_0p11()
	else
		lspconfig_pre_0p11()
	end
end

local mason = { "mason-org/mason.nvim" }

mason.version = lsp_api_versions().mason
mason.opts = {
	ui = {
		border = "rounded",
		icons = {
			package_installed   = "✓ ",
			package_pending     = "➜ ",
			package_uninstalled = "✗ "
		}
	}
}

local mason_lspconfig = { "mason-org/mason-lspconfig.nvim" }

mason_lspconfig.version = lsp_api_versions().mason
mason_lspconfig.dependencies = { mason, nvim_lspconfig }
mason_lspconfig.opts = {
	ensure_installed = {
		"lua_ls",
		"clangd"
	},
	automatic_installation = true
}

return { mason_lspconfig }
