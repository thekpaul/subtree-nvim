local luasnip = { "L3MON4D3/LuaSnip" }

luasnip.version = "*"

local nvim_cmp = { "hrsh7th/nvim-cmp" }

nvim_cmp.event = "InsertEnter"
nvim_cmp.dependencies = {
	"hrsh7th/cmp-buffer",          -- source for text in buffer
	"hrsh7th/cmp-path",            -- source for file system paths
	luasnip,                       -- snippet engine using Lua
	"saadparwaiz1/cmp_luasnip",    -- for autocompletion
	"rafamadriz/friendly-snippets" -- useful snippets (VS Code format)
}
nvim_cmp.config = function()
	local cmp = require("cmp")

	-- load VS Code style snippets from installed plugins
	require("luasnip.loaders.from_vscode").lazy_load()

	cmp.setup({
		completion = { -- Completion Menu -> `:h completeopt`
			completeopt = "menu, menuone, preview, noselect"
		},
		snippet = { -- Interaction with snippet engine
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end
		},
		mapping = cmp.mapping.preset.insert({
			["<S-Tab>"]   = cmp.mapping.select_prev_item(),
			["<Tab>"]     = cmp.mapping.select_next_item(),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-c>"]     = cmp.mapping.abort(),
			["<CR>"]      = cmp.mapping.confirm({ select = false })
		}),
		sources = cmp.config.sources({
			-- Order here is respected
			{ name = "nvim_lsp" }, -- LSP recommendations
			{ name = "luasnip" },  -- snippets
			{ name = "buffer" },   -- current buffer text
			{ name = "path" }      -- filesystem paths
		})
	})
end

return { nvim_cmp }
