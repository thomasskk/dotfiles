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
				"javascript",
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
		--sql
		b.diagnostics.sqlfluff.with({
			extra_args = { "--dialect", "postgres" },
		}),
		b.formatting.sqlfluff.with({
			extra_args = { "--dialect", "postgres" },
		}),
		-- go
		b.diagnostics.golangci_lint,
		b.formatting.gofmt,
		-- eslint
		b.code_actions.eslint_d.with({
			extra_args = { "--cache" },
		}),
		b.diagnostics.eslint_d.with({
			extra_args = { "--cache" },
		}),
		-- lua
		b.diagnostics.luacheck,
		b.formatting.stylua,
		-- rust
		b.formatting.rustfmt,
		-- shell
		b.code_actions.shellcheck,
		b.diagnostics.shellcheck,
		-- gha
		b.diagnostics.actionlint,
		-- other
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
