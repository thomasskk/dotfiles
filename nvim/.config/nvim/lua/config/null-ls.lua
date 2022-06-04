local null_ls = require("null-ls")
-- apply whatever logic you want (in this example, we'll only use null-ls)
local b = null_ls.builtins

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name ~= "tsserver"
		end,
		bufnr = bufnr,
	})
end

null_ls.setup({
	sources = {
		b.formatting.prettierd.with({
			filetypes = {
				"typescript",
				"typescriptreact",
				"css",
				"svelte",
				"scss",
				"html",
				"json",
				"yaml",
				"markdown",
				"graphql",
			},
		}),
		b.diagnostics.luacheck,
		b.formatting.rustfmt,
		b.formatting.stylua,
		b.code_actions.shellcheck,
		b.diagnostics.shellcheck,
		b.diagnostics.actionlint,
		b.formatting.shfmt.with({
			filetypes = { "bash", "zsh", "sh" },
		}),
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})
