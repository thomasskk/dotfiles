local fn = vim.fn
local opt = vim.opt
local api = vim.api

opt.termguicolors = true
opt.hidden = true
opt.clipboard = { "unnamedplus" }
opt.mouse = "a"
opt.scrolloff = 10
opt.swapfile = false
opt.splitright = true
opt.previewwindow = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.linespace = 5
opt.completeopt = { "menu", "menuone", "noselect" }
opt.autoread = true
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
opt.updatetime = 250

api.nvim_create_autocmd("BufEnter", {
	pattern = ".env",
	callback = function(args)
		vim.diagnostic.disable(args.buf)
	end,
})

api.nvim_create_autocmd("BufEnter", {
	command = "setlocal wrap",
})

api.nvim_create_autocmd("BufEnter", {
	command = "set number | set rnu",
})

api.nvim_create_autocmd({ "BufReadPre" }, {
	callback = function()
		local ok, stats = pcall(vim.loop.fs_stat, api.nvim_buf_get_name(api.nvim_get_current_buf()))
		local max_filesize = 150 * 1024 -- 150 KB
		if ok and stats and stats.size > max_filesize then
			vim.b.large_buf = true
			vim.opt_local.foldmethod = "manual"
			vim.opt_local.spell = false
			local cmp = require("cmp")
			cmp.setup({
				completion = {
					autocomplete = false,
				},
			})
		else
			vim.b.large_buf = false
			local opts = { noremap = true, silent = true }
			local keymap = vim.keymap.set
			keymap("n", "<C-d>", "<C-d>zz", opts)
			keymap("n", "<C-u>", "<C-u>zz", opts)
		end
	end,
})

api.nvim_create_autocmd("UIEnter", {
	callback = function()
		if fn.argc() == 0 and fn.line2byte("$") == -1 then
			require("telescope.builtin").oldfiles()
		end
	end,
})
