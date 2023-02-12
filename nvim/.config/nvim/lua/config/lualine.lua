local lualine = require("lualine")

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

local config = {
	options = {
		component_separators = "",
		section_separators = "",
		theme = "kanagawa",
	},
	winbar = {
		lualine_c = {},
		lualine_b = {},
		lualine_x = {
			{
				"filename",
				file_status = true,
				newfile_status = false,
				path = 1,
				shorting_target = 40,
				symbols = {
					modified = "[+]",
					readonly = "[-]",
					unnamed = "[No Name]",
					newfile = "[New]",
				},
			},
		},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {
			{
				"mode",
				fmt = string.lower,
			},
			{
				"filesize",
				cond = conditions.buffer_not_empty,
			},
			{
				"branch",
				icon = "",
				cond = conditions.buffer_not_empty,
			},
			{
				"diff",
				symbols = { added = "+", modified = "~", removed = "-" },
				diff_color = {},
			},
			{
				"diagnostics",
				sources = { "nvim_lsp", "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " " },
				diagnostics_color = {
					error = "DiagnosticError", -- Changes diagnostics' error color.
					warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
					info = "DiagnosticInfo", -- Changes diagnostics' info color.
				},
			},
			{
				function()
					return "%="
				end,
			},

			{
				"searchcount",
			},
		},
		lualine_x = {
			{
				"filetype",
			},

			{
				function()
					return "|"
				end,
				fmt = string.upper,
				padding = { left = 0, right = 0 },
			},

			{
				"o:encoding",
				cond = conditions.hide_in_width,
			},

			{
				function()
					return "|"
				end,
				fmt = string.upper,
				padding = { left = 0, right = 0 },
			},
			{
				"fileformat",
				icons_enabled = false,
			},
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

lualine.setup(config)
