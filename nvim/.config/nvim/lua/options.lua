vim.cmd([[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
augroup wraptoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * set wrap
augroup END
set termguicolors
set hidden
set number
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
]])
