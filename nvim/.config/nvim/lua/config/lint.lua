local lint = require("lint")
lint.linters_by_ft = {
	markdown = { "vale" },
	slq = { "sqlfluff" },
	c = { "cppcheck" },
	go = { "golangci_lint" },
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	svelte = { "eslint_d" },
	sveltekit = { "eslint_d" },
	python = { "flake8" },
	lua = { "luacheck" },
	sh = { "shellcheck" },
	yaml = { "yamllint" },
}

local linters = lint.linters
linters.luacheck.args = { "--globals", "vim" }
