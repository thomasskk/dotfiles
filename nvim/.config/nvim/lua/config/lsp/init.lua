local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

capabilities.textDocument.colorProvider = {
	dynamicRegistration = true,
}

capabilities.offsetEncoding = { "utf-16" }

local servers = {
	"clangd",
	"rust_analyzer",
	"pyright",
	"bashls",
	"lua_ls",
	"tailwindcss",
	"gopls",
	"svelte",
	"prismals",
	"sqls",
}

for _, server in ipairs(servers) do
	local opts = {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			local opts = {
				silent = true,
			}

			local buf_set_keymap = vim.api.nvim_buf_set_keymap

			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

			buf_set_keymap(bufnr, "n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
			buf_set_keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
			buf_set_keymap(bufnr, "n", "gi", "<cmd>Telescope lsp_implementations()<CR>", opts)
			buf_set_keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
			buf_set_keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

			if server == "svelte" then
				buf_set_keymap(bufnr, "n", "gia", ":SvelteAddMissingImports<CR>", opts)
			end
		end,
	}

	if server == "lua_ls" then
		opts.settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
			},
		}
	end

	lspconfig[server].setup(opts)
end

require("typescript-tools").setup({
	on_attach = function(_, bufnr)
		local opts = {
			silent = true,
		}

		local buf_set_keymap = vim.api.nvim_buf_set_keymap

		buf_set_keymap(bufnr, "n", "go", ":TSToolsOrganizeImports<CR>", opts)
		buf_set_keymap(bufnr, "n", "gs", ":TSToolsRemoveUnusedImports<CR>", opts)
		buf_set_keymap(bufnr, "n", "gia", ":TSToolsAddMissingImports<CR>", opts)
	end,
})

lspconfig.tailwindcss.root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.cjs")
lspconfig.gopls.root_dir = lspconfig.util.root_pattern(".git")
lspconfig.svelte.root_dir = lspconfig.util.root_pattern(".git")

vim.diagnostic.config({
	virtual_text = {
		source = "always", -- Or "if_many"
	},
	float = {
		source = "always", -- Or "if_many"
	},
})

local border = {
	{ "🭽", "FloatBorder" },
	{ "▔", "FloatBorder" },
	{ "🭾", "FloatBorder" },
	{ "▕", "FloatBorder" },
	{ "🭿", "FloatBorder" },
	{ "▁", "FloatBorder" },
	{ "🭼", "FloatBorder" },
	{ "▏", "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.cmd([[
  highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
  highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
  highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
  highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
]])
