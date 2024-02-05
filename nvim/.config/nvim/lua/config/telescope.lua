local telescope = require("telescope")

telescope.setup({
	defaults = {
		history = {
			path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
			limit = 100,
		},
		path_display = { "truncate", truncate = 5 },
		wrap_results = true,
		layout_config = {
			horizontal = { width = 0.99, preview_cutoff = 60 },
		},
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-h>"] = "which_key",
			},
		},
	},
	preview = {
		filesize_hook = function(filepath, bufnr, opts)
			local max_bytes = 10000
			local cmd = { "head", "-c", max_bytes, filepath }
			require("telescope.previewers.utils").job_maker(cmd, bufnr, opts)
		end,
	},
	pickers = {
		find_files = {
			hidden = true,
			file_ignore_patterns = { ".git/", "dist", "node_modules" },
		},
		live_grep = {
			file_ignore_patterns = { ".git/", "dist", "node_modules", "__tests__" },
			additional_args = function(opts)
				return { "--hidden" }
			end,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
		ast_grep = {
			command = {
				"sg",
				"--json=stream",
				"-p",
			}, -- must have --json and -p
			grep_open_files = false, -- search in opened files
			lang = nil, -- string value, specify language for ast-grep `nil` for default
		},
	},
})
