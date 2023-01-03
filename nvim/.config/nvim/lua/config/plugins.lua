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
	{
		"folke/trouble.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = true,
		lazy = true,
	},
	"nvim-lua/plenary.nvim",
	{
		"David-Kunz/cmp-npm",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
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
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
		ft = { "rust" },
	},
	{
		"RRethy/nvim-base16",
		config = function()
			local plugin = require("base16-colorscheme")

			plugin.with_config({
				telescope = false,
			})

			plugin.setup({
				base00 = "#222222",
				base01 = "#303030",
				base02 = "#555555",
				base03 = "#898989",
				base04 = "#898989",
				base05 = "#c0c0c0",
				base06 = "#e0e0e0",
				base07 = "#ffffff",
				base08 = "#e15d67",
				base09 = "#fc804e",
				base0A = "#e1b31a",
				base0B = "#5db129",
				base0C = "#21c992",
				base0D = "#00a3f2",
				base0E = "#b46ee0",
				base0F = "#b87d28",
			})
		end,
	},
	"yioneko/nvim-type-fmt",
	"kyazdani42/nvim-web-devicons",
	{ "neovim/nvim-lspconfig", lazy = true },
	{
		"bennypowers/nvim-regexplainer",
		config = {
			auto = true,
		},
		requires = {
			"nvim-treesitter/nvim-treesitter",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		build = "make",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	"shortcuts/no-neck-pain.nvim",
	"nvim-telescope/telescope.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	{
		"s1n7ax/nvim-window-picker",
		config = true,
		lazy = true,
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
		"ahmedkhalf/project.nvim",
	},
	{
		"cshuaimin/ssr.nvim",
		module = "ssr",
		lazy = true,
		config = {
			min_width = 50,
			min_height = 5,
			keymaps = {
				close = "q",
				next_match = "n",
				prev_match = "N",
				replace_all = "<leader><cr>",
			},
		},
	},
	{
		"ThePrimeagen/harpoon",
		lazy = true,
		config = function()
			require("telescope").load_extension("harpoon")
		end,
	},
	"MunifTanjim/nui.nvim",
	{
		"jackMort/ChatGPT.nvim",
		config = true,
		requires = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	"aduros/ai.vim",
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
		lazy = true,
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
	{ "windwp/nvim-ts-autotag", lazy = true },
	"nvim-lualine/lualine.nvim",
	"folke/which-key.nvim",
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = true,
		lazy = true,
	},
	{
		"mrshmllow/document-color.nvim",
		config = {
			mode = "background",
		},
	},
	"RRethy/vim-illuminate",
	"kylechui/nvim-surround",
	"lewis6991/gitsigns.nvim",
	"onsails/lspkind.nvim",
	"glepnir/dashboard-nvim",
	"akinsho/toggleterm.nvim",
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
	"nvim-telescope/telescope-file-browser.nvim",
	"ziontee113/syntax-tree-surfer",
	{
		"phaazon/hop.nvim",
		lazy = true,
		branch = "v2",
	},
})
