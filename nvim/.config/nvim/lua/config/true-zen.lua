require("true-zen").setup({
	modes = {
		ataraxis = {
			shade = "dark",
			quit_untoggles = true, -- type :q or :qa to quit Ataraxis mode
			padding = {
				left = 40,
				right = 20,
				top = 0,
				bottom = 0,
			},
		},
	},
	integrations = {
		kitty = { enabled = true, font = "+1" },
	},
})
