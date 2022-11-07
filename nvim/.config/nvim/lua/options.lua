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
let g:gitblame_enabled = 0
set linespace=5
set completeopt=menu,menuone,noselect
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
set spell
]])
