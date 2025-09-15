local dressing = { "stevearc/dressing.nvim" }

dressing.event = "VeryLazy"

local devicons = { 'nvim-tree/nvim-web-devicons' }

devicons.lazy = true -- API plugin!

local surround = { url = 'https://tpope.io/vim/surround.git'}

local abolish = { url = 'https://tpope.io/vim/abolish.git'}

local wakatime = { 'wakatime/vim-wakatime' }

return {
	dressing,
	devicons,
	surround,
	abolish,
	wakatime
}
