vim.opt.termguicolors = true
vim.cmd([[highlight IndentBlanklineIndent guifg=#2b3039 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineContextChar guibg=#2b3039 gui=nocombine]])

vim.opt.list = true

require("indent_blankline").setup({
	space_char_blankline = " ",
	char_highlight_list = {
		"IndentBlanklineIndent",
	},
})
