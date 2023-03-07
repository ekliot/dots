local dap = require('dap')

-- https://github.com/mfussenegger/nvim-dap/wiki/Local-and-Remote-Debugging-with-Docker

-- C/++/Rust
-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)

-- Python

-- Go (via delve)
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
-- https://harrisoncramer.me/debugging-in-neovim/
dap.adapters.go = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. '/mason/bin/dlv',
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}
dap.configurations.go = {
	{
		type = "go", -- Which adapter to use
		name = "Debug", -- Human readable name
		request = "launch", -- Whether to "launch" or "attach" to program
		program = "${file}", -- The buffer you are focused on when running nvim-dap
	},
}

-- Godot
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#godot-gdscript
dap.adapters.godot = {
  type = "server",
  host = '127.0.0.1',
  port = 6006,
}
dap.configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
    launch_scene = true,
  }
}

-- EXAMPLE MAPPINGS
-- vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
-- vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
-- vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
-- vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
-- vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
-- vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
-- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
-- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
-- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
-- vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
-- 	require('dap.ui.widgets').hover()
-- end)
-- vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
-- 	require('dap.ui.widgets').preview()
-- end)
-- vim.keymap.set('n', '<Leader>df', function()
-- 	local widgets = require('dap.ui.widgets')
-- 	widgets.centered_float(widgets.frames)
-- end)
-- vim.keymap.set('n', '<Leader>ds', function()
-- 	local widgets = require('dap.ui.widgets')
-- 	widgets.centered_float(widgets.scopes)
-- end)
