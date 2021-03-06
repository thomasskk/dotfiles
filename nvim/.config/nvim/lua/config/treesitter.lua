require("nvim-treesitter.configs").setup({
	ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	autotag = {
		enable = true,
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = {}, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
	},
})
