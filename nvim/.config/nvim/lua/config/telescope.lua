require("telescope").setup({
	defaults = {
		wrap_results = true,
		layout_config = {
			horizontal = { width = 0.99 },
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
			file_ignore_patterns = { ".git/" },
		},
		live_grep = {
			file_ignore_patterns = { ".git/" },
			additional_args = function(opts)
				return { "--hidden" }
			end,
		},
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	},
})

vim.cmd([[
augroup TelescopeWrap 
  autocmd!
  autocmd User TelescopePreviewerLoaded setlocal wrap
augroup END
]])

local opts = { noremap = true, silent = true }
