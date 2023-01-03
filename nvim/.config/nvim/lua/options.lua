vim.cmd([[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
augroup wraptoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * set wrap | set number
augroup END
set termguicolors
set hidden
set clipboard=unnamedplus
set mouse=a
set scrolloff=10
set noswapfile
set splitright
set nopreviewwindow
set incsearch
set ignorecase
set smartcase
set smartindent
set tabstop=2
set shiftwidth=2
set linespace=5
set completeopt=menu,menuone,noselect
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
set undofile
]])

vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"

-- disable diagnostic in .env files
local group = vim.api.nvim_create_augroup("__env", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = ".env",
	group = group,
	callback = function(args)
		vim.diagnostic.disable(args.buf)
	end,
})
