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
	"roobert/tailwindcss-colorizer-cmp.nvim",
	{
		"imNel/monorepo.nvim",
		config = function()
			require("monorepo").setup({})
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
	"mfussenegger/nvim-lint",
	"tpope/vim-fugitive",
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
				undercurl = false,
			})
			vim.cmd("colorscheme kanagawa")
		end,
	},
	"kyazdani42/nvim-web-devicons",
	{ "neovim/nvim-lspconfig", lazy = true },
	{ "smjonas/inc-rename.nvim", config = true },
	{ "junegunn/fzf.vim", dependencies = { "junegunn/fzf" } },
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
	{
		"stevearc/conform.nvim",
		opts = {},
	},
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
	"hrsh7th/vim-vsnip-integ",
	"hrsh7th/vim-vsnip",
	"hrsh7th/nvim-cmp",
	"rafamadriz/friendly-snippets",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-vsnip",
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
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {
			cmd = { "typescript-language-server", "--stdio" },
		},
	},
	{
		"f-person/git-blame.nvim",
		init = function()
			vim.g.gitblame_enabled = 0
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
	},
	"nvim-lualine/lualine.nvim",
	"folke/which-key.nvim",
	"kylechui/nvim-surround",
	"windwp/nvim-spectre",
	"lewis6991/gitsigns.nvim",
	"onsails/lspkind.nvim",
	"akinsho/toggleterm.nvim",
	"stevearc/dressing.nvim",
	"github/copilot.vim",
	"ziontee113/syntax-tree-surfer",
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
