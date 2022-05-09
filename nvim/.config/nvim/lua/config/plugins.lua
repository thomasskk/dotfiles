return require("packer").startup(function()
	use({
		"wbthomason/packer.nvim",
		opt = false,
	})
	use("nvim-lua/plenary.nvim")
	use("neovim/nvim-lspconfig")
	use("nvim-telescope/telescope.nvim")
	use("jose-elias-alvarez/null-ls.nvim")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use("ms-jpq/coq_nvim")
	use("ms-jpq/coq.artifacts")
	use("ms-jpq/coq.thirdparty")
	use("windwp/nvim-ts-autotag")
	use("kyazdani42/nvim-web-devicons")
	use("folke/which-key.nvim")
	use("kyazdani42/nvim-tree.lua")
	use("navarasu/onedark.nvim")
	use("lewis6991/gitsigns.nvim")
	use("itchyny/vim-gitbranch")
	use("ahmedkhalf/project.nvim")
	use("glepnir/dashboard-nvim")
	use("akinsho/toggleterm.nvim")
	use("echasnovski/mini.nvim")
	use("stevearc/dressing.nvim")
	use("github/copilot.vim")
	use({ "ellisonleao/gruvbox.nvim" })
end)
