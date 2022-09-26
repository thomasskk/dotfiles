vim.opt.list = true

vim.cmd([[highlight IndentBlanklineContextChar guifg=#949494 gui=nocombine]])

require("indent_blankline").setup({
	show_end_of_line = true,
	space_char_blankline = " ",
	show_current_context = true,
})
