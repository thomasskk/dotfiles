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

return require("packer").startup(function(use)
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

	use("hrsh7th/vim-vsnip")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")

	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use("windwp/nvim-ts-autotag")
	use("kyazdani42/nvim-web-devicons")
	use("folke/which-key.nvim")
	use("kyazdani42/nvim-tree.lua")
	use("lewis6991/gitsigns.nvim")
	use("itchyny/vim-gitbranch")
	use("ahmedkhalf/project.nvim")
	use("glepnir/dashboard-nvim")
	use("akinsho/toggleterm.nvim")
	use("stevearc/dressing.nvim")
	use("github/copilot.vim")
	use("ellisonleao/gruvbox.nvim")
	if packer_bootstrap then
		require("packer").sync()
	end
end)
