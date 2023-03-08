-- vim:foldmethod=marker:foldlevel=0
-- === STATUS/CMD {{{
vim.opt.showcmd = true -- show partial commands in the last line of the screen
vim.opt.cmdheight = 2  -- vim.opt.the command window height to 2 lines
vim.opt.laststatus = 2 -- always display the status line, evin if only one window is displayed

vim.opt.number = true          -- display line numbers
vim.opt.relativenumber = false -- line numbers are relative to cursor
vim.opt.ruler = true           -- display cursor position
vim.opt.signcolumn = "auto"
-- }}}
-- === INDENTS {{{
vim.opt.linebreak = true
vim.opt.textwidth = 420

vim.opt.tabstop = 4     -- number of spaces that <Tab> counts for in file
vim.opt.softtabstop = 4 -- number of spaces that <Tab> counts for when editing
vim.opt.shiftwidth = 4  -- number of spaces autoindent uses
vim.opt.expandtab = false

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.wrap = true

vim.opt.colorcolumn = "80"
-- }}}
-- === SEARCH {{{
vim.opt.incsearch = true -- search as characters are entered
vim.opt.hlsearch = true  -- Highlight searches

-- Use case insensitive search, except when using capital letters
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- }}}
-- === CURSOR {{{
vim.opt.scrolloff = 7 -- keep 7 lines of context around the cursor
vim.opt.mat = 2       -- N/10 sec cursor blink for bracket match
vim.opt.cursorline = true

vim.opt.startofline = false
-- }}}
-- === FOLDING {{{
vim.opt.foldmethod = 'indent'
vim.opt.foldcolumn = '1'      -- left margin
vim.opt.foldnestmax = 10    -- max 10 depth
vim.opt.foldenable = true   -- don't fold files by default on open
vim.opt.foldlevelstart = 1 -- start with fold level of 1
vim.opt.foldopen = "hor,mark,percent,quickfix,search,tag,undo"
-- }}}
-- === WINDOWS {{{
vim.opt.splitbelow = true
vim.opt.splitright = true
-- }}}
-- === MISC {{{
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.termguicolors = true
-- }}}
