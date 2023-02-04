require("nvim-treesitter.configs").setup({
	ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = function()
			return vim.b.large_buf
		end,
		additional_vim_regex_highlighting = false,
	},
})
