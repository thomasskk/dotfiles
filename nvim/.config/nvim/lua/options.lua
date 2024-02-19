local fn = vim.fn
local opt = vim.opt
local api = vim.api
local auto_cmd = vim.api.nvim_create_autocmd

opt.termguicolors = true
opt.hidden = true
opt.clipboard = { "unnamedplus" }
opt.mouse = "a"
opt.scrolloff = 15
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
opt.laststatus = 3
vim.g.copilot_node_command = "/home/thomas/.local/share/fnm/node-versions/v18.15.0/installation/bin/node"

auto_cmd("BufEnter", {
	command = "setlocal wrap",
})

auto_cmd("BufEnter", {
	command = "set number | set rnu",
})

auto_cmd({ "BufReadPre" }, {
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

auto_cmd("UIEnter", {
	callback = function()
		if fn.argc() == 0 and fn.line2byte("$") == -1 then
			require("telescope.builtin").oldfiles()
		end
	end,
})

auto_cmd({ "FocusGained", "BufEnter" }, {
	pattern = { "*.*" },
	callback = function()
		vim.cmd([[checktime]])
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
