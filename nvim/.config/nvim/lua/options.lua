vim.cmd([[
:set hidden
:set number
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:colorscheme gruvbox
:augroup END
:hi Normal guibg=none ctermbg=none
:hi LineNr guibg=none ctermbg=none
:hi Folded guibg=none ctermbg=none
:hi NonText guibg=none ctermbg=none
:hi SpecialKey guibg=none ctermbg=none
:hi VertSplit guibg=none ctermbg=none
:hi SignColumn guibg=none ctermbg=none
:hi EndOfBuffer guibg=none ctermbg=none
]])
