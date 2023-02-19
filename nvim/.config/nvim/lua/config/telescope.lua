local telescope = require("telescope")

local previewers = require("telescope.previewers")

local new_maker = function(filepath, bufnr, opts)
	opts = opts or {}

	filepath = vim.fn.expand(filepath)
	vim.loop.fs_stat(filepath, function(_, stat)
		if not stat then
			return
		end
		if stat.size > 100000 then
			return
		else
			previewers.buffer_previewer_maker(filepath, bufnr, opts)
		end
	end)
end

telescope.setup({
	defaults = {
		buffer_previewer_maker = new_maker,
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
	pickers = {
		find_files = {
			hidden = true,
			file_ignore_patterns = { ".git/", "dist", "node_modules" },
		},
		live_grep = {
			file_ignore_patterns = { ".git/", "dist", "node_modules" },
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
		file_browser = {
			cwd_to_path = true,
			path = "%:p:h",
			hijack_netrw = true,
			mappings = {
				["i"] = {},
				["n"] = {},
			},
		},
	},
})

telescope.load_extension("file_browser")
