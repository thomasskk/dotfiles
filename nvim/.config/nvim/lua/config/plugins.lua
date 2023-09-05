local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
	"thomasskk/lualine-lsp-progress",
	"nvim-lua/plenary.nvim",
	{
		"imNel/monorepo.nvim",
		config = function()
			require("monorepo").setup({
				-- Your config here!
			})
		end,
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		"AckslD/muren.nvim",
		config = true,
	},
	{
		"ivanjermakov/troublesum.nvim",
		config = function()
			require("troublesum").setup()
		end,
	},
	{
		"jake-stewart/jfind.nvim",
		keys = {
			{ "<c-f>" },
		},
		config = function()
			require("jfind").setup({
				exclude = {
					".git",
					".idea",
					".vscode",
					".sass-cache",
					".class",
					"__pycache__",
					"node_modules",
					"target",
					"build",
					"tmp",
					"assets",
					"dist",
					"public",
					"*.iml",
					"*.meta",
				},
				border = "rounded",
				tmux = true,
				formatPaths = true,
				key = "<c-f>",
			})
		end,
	},
	"tpope/vim-fugitive",
	{
		dir = "/home/thomas/tsc.nvim",
		config = function()
			require("tsc").setup()
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "main",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"Fildo7525/pretty_hover",
		event = "LspAttach",
		opts = {},
	},
	{
		"rareitems/printer.nvim",
		config = function()
			require("printer").setup({
				keymap = "gp",
				behavior = "insert_below",
				formatters = {
					lua = function(inside, variable)
						return string.format('print("%s: " .. %s)', inside, variable)
					end,
				},
				add_to_inside = function(text)
					return string.format("[%s:%s] %s", vim.fn.expand("%"), vim.fn.line("."), text)
				end,
			})

			vim.keymap.set("n", "gP", "<Plug>(printer_print)iw")
		end,
	},
	"kkharji/sqlite.lua",
	{
		"tzachar/local-highlight.nvim",
		config = function()
			require("local-highlight").setup({
				file_types = { "typescript", "typescriptreact" },
				hlgroup = "CursorLine",
			})
		end,
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
		ft = { "rust" },
	},
	{
		"nvim-telescope/telescope-smart-history.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("smart_history")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				overrides = function()
					return {
						DiagnosticUnderlineError = { undercurl = false, underline = true },
						DiagnosticUnderlineWarn = { undercurl = false, underline = true },
						DiagnosticUnderlineInfo = { undercurl = false, underline = true },
						DiagnosticUnderlineHint = { undercurl = false, underline = true },
					}
				end,
			})
			vim.cmd("colorscheme kanagawa")
		end,
	},
	"kyazdani42/nvim-web-devicons",
	{ "neovim/nvim-lspconfig",   lazy = true },
	{ "smjonas/inc-rename.nvim", config = true },
	{ "junegunn/fzf.vim",        dependencies = { "junegunn/fzf" } },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		build = "make",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"shortcuts/no-neck-pain.nvim",
		config = {
			mappings = {
				toggle = "<space>np",
			},
			buffers = {
				right = {
					enabled = false,
				},
			},
		},
	},
	"nvim-telescope/telescope.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = {
			highlight = {
				enable = true,
				disable = { "comment", "jsdoc" },
			},
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"ThePrimeagen/harpoon",
		lazy = true,
		config = function()
			require("telescope").load_extension("harpoon")
		end,
	},
	"MunifTanjim/nui.nvim",
	{ "hrsh7th/vim-vsnip-integ" },
	{ "hrsh7th/vim-vsnip" },
	"hrsh7th/nvim-cmp",
	"rafamadriz/friendly-snippets",
	"hrsh7th/cmp-nvim-lsp",
	{ "hrsh7th/cmp-vsnip" },
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"ray-x/cmp-treesitter",
	{
		"numToStr/Comment.nvim",
		config = true,
	},
	{
		"williamboman/mason.nvim",
		config = true,
	},
	"jose-elias-alvarez/typescript.nvim",
	{
		"f-person/git-blame.nvim",
		init = function()
			vim.g.gitblame_enabled = 0
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = true,
	},
	"nvim-lualine/lualine.nvim",
	"folke/which-key.nvim",
	"kylechui/nvim-surround",
	"windwp/nvim-spectre",
	{ "lewis6991/gitsigns.nvim", commmit = "55f8fc7b13205d44359080ed00095674c353bd76" },
	"onsails/lspkind.nvim",
	"akinsho/toggleterm.nvim",
	"eandrju/cellular-automaton.nvim",
	"stevearc/dressing.nvim",
	{
		"princejoogie/dir-telescope.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = {
			hidden = true,
			respect_gitignore = true,
		},
	},
	"github/copilot.vim",
	"ziontee113/syntax-tree-surfer",
	{ "petertriho/nvim-scrollbar", config = true },
	{
		"thomasskk/git-conflict.nvim",
		config = function()
			require("git-conflict").setup({
				default_mappings = true, -- disable buffer local mapping created by this plugin
				default_commands = true, -- disable commands created by this plugin
				disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
				highlights = {
					-- They must have background color, otherwise the default color will be used
					incoming = "DiffText",
					current = "DiffAdd",
				},
			})
			vim.api.nvim_set_hl(0, "GitConflictIncoming", { background = "#25394B", bold = false })
			vim.api.nvim_set_hl(0, "GitConflictCurrent", { background = "#25403B", bold = false })
			vim.cmd([[
					hi GitConflictIncomingLabel guibg=#2F628F
					hi GitConflictCurrentLabel guibg=#2F7366
			]])
		end,
	},
	{
		"axkirillov/hbac.nvim",
		config = function()
			require("hbac").setup({
				treshold = 20,
			})
		end,
	},
})
