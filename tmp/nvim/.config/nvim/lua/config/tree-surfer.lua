require("syntax-tree-surfer")
-- Syntax Tree Surfer
local opts = { noremap = true, silent = true }

-- Visual Selection from Normal Mode
vim.keymap.set("n", "vx", "<cmd>STSSelectMasterNode<cr>", opts)
vim.keymap.set("n", "vn", "<cmd>STSSelectCurrentNode<cr>", opts)
