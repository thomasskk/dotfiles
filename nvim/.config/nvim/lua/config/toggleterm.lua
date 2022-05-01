local Terminal = require("toggleterm.terminal").Terminal
local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float" })
local lazygit = Terminal:new({ cmd = "lazygit", count = 5, hidden = true, direction = "float" })

function _lazydocker_toggle()
	lazydocker:toggle()
end

function _lazygit_toggle()
	lazygit:toggle()
end

require("toggleterm").setup({
	size = 30,
})

vim.cmd([[
	let g:toggleterm_terminal_mapping = '<C-t>'
	nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
	inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
	tnoremap <C-d> <C-\><C-n>
]])
