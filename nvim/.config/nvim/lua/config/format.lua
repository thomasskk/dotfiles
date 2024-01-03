local slow_format_filetypes = {}

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofmt" },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		css = { "prettierd" },
		svelte = { "prettierd" },
		sveltekit = { "prettierd" },
		scss = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		python = { "black" },
		sh = { "shfmt" },
		zsh = { "shfmt" },
		bash = { "shfmt" },
		sql = { "sqlfluff" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		rust = { "rustfmt" },
		["*"] = { "codespell" },
		["_"] = { "trim_whitespace" },
	},

	formatters = {
		sqlfluff = {
			extra_args = { "--dialect", "postgres" },
		},
	},

	format_on_save = function(bufnr)
		local bufname = vim.api.nvim_buf_get_name(bufnr)
		if bufname:match("/node_modules/") then
			return
		end

		if slow_format_filetypes[vim.bo[bufnr].filetype] then
			return
		end
		local function on_format(err)
			if err and err:match("timeout$") then
				slow_format_filetypes[vim.bo[bufnr].filetype] = true
			end
		end

		return { timeout_ms = 200, lsp_fallback = true }, on_format
	end,

	format_after_save = function(bufnr)
		local bufname = vim.api.nvim_buf_get_name(bufnr)
		if bufname:match("/node_modules/") then
			return
		end

		if not slow_format_filetypes[vim.bo[bufnr].filetype] then
			return
		end
		return { lsp_fallback = true }
	end,
})
