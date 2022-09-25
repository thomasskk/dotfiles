vim.g.catppuccin_flavour = "mocha"

local colors = require("catppuccin.palettes").get_palette() -- fetch colors from g:catppuccin_flavour palette
require("catppuccin").setup({
	transparent_background = false,
	term_colors = false,
	compile = {
		enabled = false,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
	},
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
	integrations = {
		neotree = {
			enabled = true,
			show_root = true, -- makes the root folder not transparent
			transparent_panel = false, -- make the panel transparent
		},
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		indent_blankline = {
			enabled = true,
			colored_indent_levels = false,
		},
		gitsigns = true,
		hop = true,
		cmp = true,
		treesitter_context = true,
		treesitter = true,
		telescope = true,
		lsp_trouble = true,
		illuminate = true,
	},
	color_overrides = {},
	-- fdsfsd
	highlight_overrides = {},
	custom_highlights = {
		Comment = { fg = "#898989", style = { "italic" } },
	},
})

vim.cmd([[colorscheme catppuccin]])
