local startify = { 'mhinz/vim-startify' }

startify.cmd = "Startify"
startify.init = function()
	vim.g.startify_custom_header = {
		[[                                         __ __                  ]],
		[[                       __               /\ \\ \                 ]],
		[[              __   __ /\_\    ___ ___   \ \ \\ \                ]],
		[[             /\ \ /\ \\/\ \ /` __` __`\  \ \ \\ \               ]],
		[[             \ \ \_/ / \ \ \/\ \/\ \/\ \  \ \_\\_\              ]],
		[[              \ \___/   \ \_\ \_\ \_\ \_\  \/\_\\_\             ]],
		[[               \/__/     \/_/\/_/\/_/\/_/   \/_//_/             ]],
		[[                                                                ]],
	}
	-- Startify will respect preset values for the following options:
 --	vim.opt.sessionoptions = { blank, curdir, folds, help, tabpages, winpos }
end

return { startify }
