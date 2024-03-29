-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		-- Enable completion triggered by <c-x><c-o>
		-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap=true, silent=true, buffer=bufnr }
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
		-- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
		-- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
		-- vim.keymap.set('n', '<leader>wl', function()
			--              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			-- end, bufopts)
			-- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
			-- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
	end
})

require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {
		-- Replace these with whatever servers you want to install
	}
})

vim.o.completeopt = 'menu,menuone,noselect,preview'

local cmp = require('cmp')
cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		-- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
		-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' }, -- For luasnip users.
	}, {
		{ name = 'buffer' },
	})
})

local lspconfig = require('lspconfig')
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason-lspconfig').setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			capabilities = lsp_capabilities,
		})
	end,

	['pylsp'] = function ()
		lspconfig['pylsp'].setup({
			capabilities = lsp_capabilities,
			settings = {
				pylsp = {
					plugins = {
						pycodestyle = {
							enabled = false
						},
						-- ruff = {
						-- 	enabled = true
						-- }
					}
				}
			}
		})
	end
})

-- custom stuff goes here
-- lsp.configure('gdscript', {
	-- 	force_setup = true, -- because the LSP is global. Read more on lsp-zero docs about this.
	-- 	single_file_support = false,
	-- 	root_dir = require('lspconfig.util').root_pattern('project.godot', '.git'),
	-- 	filetypes = {'gd', 'gdscript', 'gdscript3' },
	-- 	-- cmd = {""}
	-- })
	--
