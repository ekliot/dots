local lsp = require("lsp-zero")

lsp.preset("recommended")

-- custom stuff goes here
lsp.configure('gdscript', {
	force_setup = true, -- because the LSP is global. Read more on lsp-zero docs about this.
	single_file_support = false,
	root_dir = require('lspconfig.util').root_pattern('project.godot', '.git'),
	filetypes = {'gd', 'gdscript', 'gdscript3' },
	-- cmd = {""}
})

lsp.setup()
