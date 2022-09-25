require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "vy", function()
	vim.cmd([[:HopLineStart]])
	vim.schedule(function()
		vim.cmd([[:normal @f]])
	end)
end, opts)

vim.keymap.set("n", "vu", function()
	vim.cmd([[:HopWord]])
	vim.schedule(function()
		vim.cmd([[:normal @f]])
	end)
end, opts)
