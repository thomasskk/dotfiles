require("lint").linters_by_ft = {
	markdown = { "vale" },
	slq = { "sqlfluff" },
	c = { "cppcheck" },
	go = { "golangci_lint" },
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	python = { "flake8" },
	lua = { "luacheck" },
	sh = { "shellcheck" },
	yaml = { "yamllint" },
}

local luacheck = require("lint").linters.luacheck
luacheck.args = { "--globals", "vim" }

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
