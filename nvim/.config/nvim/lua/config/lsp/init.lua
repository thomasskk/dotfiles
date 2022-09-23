local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

capabilities.textDocument.colorProvider = {
	dynamicRegistration = true,
}

local servers = {
	"clangd",
	"rust_analyzer",
	"pyright",
	"bashls",
	"sumneko_lua",
	"tailwindcss",
	"gopls",
	"svelte",
	"sqlls",
	"prismals",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			local opts = {
				silent = true,
			}
			if client.server_capabilities.colorProvider then
				-- Attach document colour support
				require("document-color").buf_attach(bufnr)
			end

			local buf_set_keymap = vim.api.nvim_buf_set_keymap
			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
			buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
			buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
			buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
			buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
			buf_set_keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
			buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
			buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
		end,
	})
end

require("typescript").setup({
	disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false, -- enable debug logging for commands
	server = { -- pass options to lspconfig's setup method
		init_options = {
			maxTsServerMemory = 8192,
		},
		on_attach = function(client, bufnr)
			if client.name == "tsserver" then
				local set_keymap = vim.api.nvim_set_keymap
				local opts = {
					silent = true,
				}
				set_keymap("n", "go", ":TypescriptOrganizeImports<CR>", opts)
				set_keymap("n", "gs", ":TypescriptRemoveUnused<CR>", opts)
				set_keymap("n", "gr", ":TypescriptRenameFile<CR>", opts)
				set_keymap("n", "gia", ":TypescriptAddMissingImports<CR>", opts)
			end
		end,
	},
})

lspconfig.tailwindcss.root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.cjs")
lspconfig.gopls.root_dir = lspconfig.util.root_pattern(".git")
lspconfig.svelte.root_dir = lspconfig.util.root_pattern(".git")

lspconfig.emmet_ls.setup({
	filetypes = { "html", "css", "typescriptreact", "svelte", "javascriptreact" },
	capabilities = capabilities,
	root_dir = lspconfig.util.root_pattern(".git"),
})

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = "single"
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.diagnostic.config({
	virtual_text = {
		source = "always", -- Or "if_many"
	},
	float = {
		source = "always", -- Or "if_many"
	},
})
