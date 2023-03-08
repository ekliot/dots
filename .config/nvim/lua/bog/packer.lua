-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		-- or                            , branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}
	-- use('nvim-treesitter/playground')

	use('tpope/vim-fugitive')

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },    -- Required
			{ 'williamboman/mason.nvim' },  -- Optional
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'hrsh7th/cmp-buffer' }, -- Optional
			{ 'hrsh7th/cmp-path' }, -- Optional
			{ 'saadparwaiz1/cmp_luasnip' }, -- Optional
			{ 'hrsh7th/cmp-nvim-lua' }, -- Optional

			-- Snippets
			{ 'L3MON4D3/LuaSnip' },    -- Required
			{ 'rafamadriz/friendly-snippets' }, -- Optional
		}
	}

	use('mfussenegger/nvim-dap')
	-- TODO https://github.com/rcarriga/nvim-dap-ui

	-- TODO https://github.com/simrat39/rust-tools.nvim

	use('vimwiki/vimwiki')

	-- for some reason this only works here
	vim.g.vimwiki_list = {
		{
			path = '~/grimoire/',
			syntax = 'default',
			ext = '.wiki'
		}
	}
	vim.g.vimwiki_global_ext = 0
	vim.g.vimwiki_folding = 'expr'

	-- === AESTHETICS

	use {
		'ellisonleao/gruvbox.nvim',
		as = 'gruvbox',
		config = function()
			vim.o.background = "dark"
			vim.cmd([[colorscheme gruvbox]])
		end
	}

	use('nvim-lualine/lualine.nvim')

	use {
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}

	use('tpope/vim-commentary')

	use( "lukas-reineke/indent-blankline.nvim" )
end)
