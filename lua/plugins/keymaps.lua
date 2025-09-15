local which_key = { "folke/which-key.nvim" }

which_key.event = "VeryLazy"
which_key.config = true
which_key.keys = {
	{
		"<leader>?",
		function() require("which-key").show({ global = false }) end,
		desc = "Buffer Local Keymaps (which-key)"
	}
}

return { which_key }
