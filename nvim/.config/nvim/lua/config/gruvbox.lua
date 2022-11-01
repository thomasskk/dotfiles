local config = require("gruvbox").config

require("gruvbox").setup({
	undercurl = true,
	underline = true,
	bold = true,
	italic = true,
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true, -- invert background for search, diffs, statuslines and errors
	contrast = "hard", -- can be "hard", "soft" or empty string
	overrides = {},
	dim_inactive = false,
	transparent_mode = false,
})

vim.cmd([[
set background=dark
colorscheme gruvbox
hi SignColumn guibg=none
hi VertSplit guibg=none ctermbg=none
hi GruvboxRedSign guibg=none
hi GruvboxGreenSign guibg=none
hi GruvboxYellowSign guibg=none
hi GruvboxBlueSign guibg=none
hi GruvboxPurpleSign guibg=none
hi GruvboxAquaSign guibg=none
hi GruvboxOrangeSign guibg=none
hi GruvboxRedUnderline gui=underline
hi GruvboxRedUnderline gui=underline
hi GruvboxGreenUnderline gui=underline guisp=green
hi GruvboxYellowUnderline gui=underline guisp=yellow
hi GruvboxBlueUnderline gui=underline guisp=blue
hi GruvboxPurpleUnderline gui=underline guisp=purple
hi GruvboxAquaUnderline gui=underline guisp=aqua
hi GruvboxOrangeUnderline gui=underline guisp=orange
hi GruvboxRedUnderline gui=underline guisp=red
hi TreesitterContext guibg=#1D2021
hi NormalFloat guibg=#272c2e
hi FloatBorder guibg=#272c2e
]])
