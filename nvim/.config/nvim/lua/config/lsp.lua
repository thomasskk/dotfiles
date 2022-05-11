local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

lspconfig.emmet_ls.setup({
	filetypes = { "html", "css", "typescriptreact", "javascriptreact" },
	capabilities = capabilities,
})

lspconfig.eslint.setup({
	root_dir = lspconfig.util.root_pattern(".git"),
	settings = {
		nodePath = ".yarn/sdks/",
	},
})

lspconfig.tailwindcss.setup({
	root_dir = lspconfig.util.root_pattern("tailwind.config.js"),
})

local servers = {
	"clangd",
	"rust_analyzer",
	"pyright",
	"bashls",
	"tailwindcss",
	"tsserver",
	"sumneko_lua",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		capabilities = capabilities,
	})
end

lspconfig.tsserver.setup({
	-- Needed for inlayHints. Merge this table with your settings or copy
	-- it from the source if you want to add your own init_options.
	init_options = require("nvim-lsp-ts-utils").init_options,

	root_dir = lspconfig.util.root_pattern(".git"),
	--
	on_attach = function(client, bufnr)
		local ts_utils = require("nvim-lsp-ts-utils")

		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false

		-- defaults
		ts_utils.setup({
			debug = false,
			disable_commands = false,
			enable_import_on_completion = false,

			-- import all
			import_all_timeout = 5000, -- ms
			-- lower numbers = higher priority
			import_all_priorities = {
				same_file = 1, -- add to existing import statement
				local_files = 2, -- git files or files with relative path markers
				buffer_content = 3, -- loaded buffer content
				buffers = 4, -- loaded buffer names
			},
			import_all_scan_buffers = 100,
			import_all_select_source = false,
			-- if false will avoid organizing imports
			always_organize_imports = true,

			-- filter diagnostics
			filter_out_diagnostics_by_severity = {},
			filter_out_diagnostics_by_code = {},

			auto_inlay_hints = false,
			inlay_hints_highlight = "Comment",
			inlay_hints_priority = 200, -- priority of the hint extmarks
			inlay_hints_throttle = 150, -- throttle the inlay hint request
			inlay_hints_format = { -- format options for individual hint kind
				Type = {},
				Parameter = {},
				Enum = {},
				-- Example format customization for `Type` kind:
				-- Type = {
				--     highlight = "Comment",
				--     text = function(text)
				--         return "->" .. text:sub(2)
				--     end,
				-- },
			},
			update_imports_on_move = true,
			watch_dir = nil,
		})

		-- required to fix code action ranges and filter diagnostics
		ts_utils.setup_client(client)

		-- no default maps, so you may want to define some here
		local opts = {
			silent = true,
		}
		vim.api.nvim_set_keymap("n", "gs", ":TSLspOrganize<CR>", opts)
		vim.api.nvim_set_keymap("n", "gr", ":TSLspRenameFile<CR>", opts)
		vim.api.nvim_set_keymap("n", "gi", ":TSLspImportAll<CR>", opts)
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	end,
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
