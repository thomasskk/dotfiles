local null_ls = require("null-ls")
local b = null_ls.builtins
null_ls.setup({
	sources = {
		b.formatting.prettier,
		b.diagnostics.luacheck,
		b.code_actions.gitsigns,
		b.formatting.rustfmt,
		b.formatting.stylua,
		b.code_actions.shellcheck,
		b.diagnostics.shellcheck,
		b.formatting.shfmt.with({
			filetypes = { "bash", "zsh", "sh" },
		}),
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
			augroup LspFormatting
			autocmd! * <buffer>
			autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
			augroup END
			]])
		end
	end,
})
