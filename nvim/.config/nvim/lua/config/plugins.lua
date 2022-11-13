local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup({
	function(use)
		use({
			"wbthomason/packer.nvim",
			opt = false,
		})
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
		})
		use("nvim-lua/plenary.nvim")
		use({
			"David-Kunz/cmp-npm",
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})
		use({
			"saecki/crates.nvim",
			event = { "BufRead Cargo.toml" },
			requires = { { "nvim-lua/plenary.nvim" } },
			config = function()
				require("crates").setup()
			end,
		})
		use("kyazdani42/nvim-web-devicons")
		use("neovim/nvim-lspconfig")
		use("nvim-telescope/telescope.nvim")
		use("jose-elias-alvarez/null-ls.nvim")
		use({
			"s1n7ax/nvim-window-picker",
			tag = "v1.*",
			config = function()
				require("window-picker").setup()
			end,
		})
		use("b0o/incline.nvim")
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
		})
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			setup = function()
				vim.g.mkdp_filetypes = { "markdown" }
			end,
			ft = { "markdown" },
		})
		use({
			"cshuaimin/ssr.nvim",
			module = "ssr",
			-- Calling setup is optional.
			config = function()
				require("ssr").setup({
					min_width = 50,
					min_height = 5,
					keymaps = {
						close = "q",
						next_match = "n",
						prev_match = "N",
						replace_all = "<leader><cr>",
					},
				})
			end,
		})
		use("ThePrimeagen/harpoon")
		use("hrsh7th/vim-vsnip")
		use("hrsh7th/vim-vsnip-integ")
		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-nvim-lsp-signature-help")
		use("rafamadriz/friendly-snippets")
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-vsnip")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-cmdline")
		use("ray-x/cmp-treesitter")
		use("almo7aya/openingh.nvim")
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})
		use({
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup()
			end,
		})
		use({
			"williamboman/mason.nvim",
			config = function()
				require("mason").setup({})
			end,
		})
		use("jose-elias-alvarez/typescript.nvim")
		use("f-person/git-blame.nvim")
		use({
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		})

		use("windwp/nvim-ts-autotag")
		use({
			"nvim-lualine/lualine.nvim",
			config = function()
				require("lualine").setup({
					options = { theme = "gruvbox" },
				})
			end,
		})
		use("folke/which-key.nvim")
		use({
			"nvim-neo-tree/neo-tree.nvim",
			branch = "main",
			requires = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
			},
		})
		use({
			"nvim-treesitter/nvim-treesitter-context",
			config = function()
				require("treesitter-context").setup({})
			end,
		})
		use({
			"mrshmllow/document-color.nvim",
			config = function()
				require("document-color").setup({
					-- Default options
					mode = "background", -- "background" | "foreground" | "single"
				})
			end,
		})
		use("RRethy/vim-illuminate")
		use("kylechui/nvim-surround")
		use("Hvassaa/sterm.nvim")
		use("lewis6991/gitsigns.nvim")
		use("onsails/lspkind.nvim")
		use("itchyny/vim-gitbranch")
		use("ahmedkhalf/project.nvim")
		use("glepnir/dashboard-nvim")
		use("akinsho/toggleterm.nvim")
		use("stevearc/dressing.nvim")
		use({
			"princejoogie/dir-telescope.nvim",
			-- telescope.nvim is a required dependency
			requires = { "nvim-telescope/telescope.nvim" },
			config = function()
				require("dir-telescope").setup({
					hidden = true,
					respect_gitignore = true,
				})
			end,
		})
		use("github/copilot.vim")
		use("ellisonleao/gruvbox.nvim")
		use("ziontee113/syntax-tree-surfer")
		use({
			"phaazon/hop.nvim",
			branch = "v2", -- optional but strongly recommended
		})
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
