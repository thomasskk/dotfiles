local lualine = require("lualine")

local colors = {
	bg = "#282828",
	brown = "#403a37",
	fg = "#bbc2cf",
	green = "#5DB129",
	orange = "#FC804E",
	violet = "#B46EE0",
	magenta = "#c678dd",
	blue = "#00A3F2",
	red = "#E15D67",
	black = "#000000",
}

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

local function lsp_progress()
	local messages = vim.lsp.util.get_progress_messages()
	if #messages == 0 then
		return
	end
	local status = {}
	for _, msg in pairs(messages) do
		table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
	end
	local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
	local ms = vim.loop.hrtime() / 1000000
	local frame = math.floor(ms / 120) % #spinners
	return table.concat(status, " | ") .. " " .. spinners[frame + 1]
end

local config = {
	options = {
		component_separators = "",
		section_separators = "",
		theme = {
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
	},
	winbar = {
		lualine_c = {
			{
				"lsp_progress",
				colors = {
					percentage = colors.white,
					title = colors.white,
					message = colors.white,
					spinner = colors.white,
					lsp_client_name = colors.white,
					use = true,
				},
				separators = {
					component = " ",
					progress = " | ",
				},
				display_components = { "spinner", { "title", "percentage" } },
				timer = { progress_enddelay = 100, spinner = 200, lsp_client_name_enddelay = 100 },
				spinner_symbols = {
					"⠋",
					"⠙",
					"⠹",
					"⠸",
					"⠼",
					"⠴",
					"⠦",
					"⠧",
					"⠇",
					"⠏",
				},
			},
		},
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
				color = { bg = "#A99A85", fg = colors.bg },
			},
			{
				"filesize",
				cond = conditions.buffer_not_empty,
				color = { bg = "#4F4743", fg = colors.white },
			},
			{
				"branch",
				icon = "",
				cond = conditions.buffer_not_empty,
			},
			{
				"diff",
				symbols = { added = "+", modified = "~", removed = "-" },
				diff_color = {
					added = { fg = colors.green },
					modified = { fg = colors.orange },
					removed = { fg = colors.red },
				},
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
				colored = true,
			},
			{
				function()
					return "%="
				end,
			},

			{
				"searchcount",
				color = { bg = "#4F4743", fg = colors.white },
			},
		},
		lualine_x = {
			{
				"filetype",
				color = { fg = colors.white },
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
				color = { fg = colors.white },
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
				color = { fg = colors.white },
			},
			{
				function()
					local buffers = 0
					for b = 1, vim.fn.bufnr("$") do
						if vim.fn.buflisted(b) ~= 0 and vim.api.nvim_buf_get_option(b, "buftype") ~= "quickfix" then
							buffers = buffers + 1
						end
					end

					return " " .. buffers
				end,
				color = { bg = "#4F4743", fg = colors.white },
			},

			{
				"location",
				fmt = string.lower,
				color = { bg = "#A99A85", fg = colors.bg, gui = "bold" },
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
