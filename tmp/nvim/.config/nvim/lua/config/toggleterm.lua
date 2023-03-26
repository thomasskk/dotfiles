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
	size = 70,
	direction = "vertical",
})

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd([[
autocmd! TermOpen term://* lua set_terminal_keymaps()
let g:toggleterm_terminal_mapping = '<C-t>'
nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
]])
