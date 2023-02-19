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
	"sqlls",
	"prismals",
}

for _, server in ipairs(servers) do
	local opts = {
		capabilities = capabilities,
		on_attach = function(_, bufnr)
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

local typescript_config = {
	disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false, -- enable debug logging for commands
	server = { -- pass options to lspconfig's setup method
		init_options = {
			maxTsServerMemory = 8192,
		},
		on_attach = function(client)
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
}

require("typescript").setup(typescript_config)

local rust_analyzer_config = {
	imports = {
		granularity = {
			group = "module",
		},
		prefix = "self",
	},
	cargo = {
		buildScripts = {
			enable = true,
		},
	},
	diagnostics = { disabled = { "unresolved-proc-macro" } },
	checkOnSave = {
		command = "clippy",
		allTargets = false,
	},
}

if vim.fn.getcwd() == "/home/thomas/dev/os" then
	rust_analyzer_config["cargo"] = { target = "thumbv7m-none-eabi" }
end

lspconfig.rust_analyzer.settings = {
	["rust-analyzer"] = rust_analyzer_config,
}

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
