-- auto write markdown files when navigating away from the buffer
vim.api.nvim_create_autocmd("FileType", {pattern = "markdown", command = "set awa"})

journal_dir = 'journal/'

function get_latest_journal(j_dir)
	-- fd = io.popen('find '..j_dir..' -printf "%f\n" | egrep "[0-9]{4}-[0-1][0-9]-[0-3][0-9].md" | sort -r | head -n 1')
	fd = io.popen('ls '..j_dir..' | egrep "[0-9]{4}-[0-1][0-9]-[0-3][0-9].md" | sort -r | head -n 1')
	item = fd:read('a'):gsub("%s+", "")
	return(item)
end

function journal_template()
	last_journal = get_latest_journal(journal_dir)
	-- double newlines don't work well here? let's just hope we trim trailing whitespace on write...
	-- TODO would be neat to do a "quote of the day" kidna thing as a subtitle
	template =  '# '..os.date('%a | %b %d, %Y')..'\n \n'..
				'[['..journal_dir..last_journal..'|Last]] <<>> Next\n \n'..
				'## To Do\n \n'..
				'- [ ] \n \n'..
				'## Notes\n \n'
	return(template)
end

require('mkdnflow').setup({
	modules = {
		bib = false,
		buffers = true,
		conceal = true,
		cursor = true,
		folds = true,
		links = true,
		lists = true,
		maps = true,
		paths = true,
		tables = true,
		yaml = false
	},
	filetypes = {md = true, rmd = true, markdown = true},
	create_dirs = true,
	perspective = {
		priority = 'root',
		fallback = 'current',
		root_tell = '.git',
		nvim_wd_heel = false,
		update = false
	},
	wrap = false,
	bib = {
		default_path = nil,
		find_in_root = true
	},
	silent = false,
	links = {
		style = 'wiki',
		name_is_source = false,
		conceal = true,
		context = 0,
		implicit_extension = 'md',
		transform_implicit = function(input)
			if input == 'TODAY' then
				return(journal_dir..os.date('%Y-%m-%d'))
			end
			return input
		end,
		transform_explicit = false
		-- transform_explicit = function(text)
			-- text = text:gsub(" ", "-")
			-- text = text:lower()
			-- text = os.date('%Y-%m-%d_')..text
			-- return(text)
		-- end
	},
	new_file_template = {
		use_template = true,
		placeholders = {
			before = {
				date = 'os_date'
			},
			after = {
				titlee = function()
					fname = vim.api.nvim_buf_get_name(0)

					if fname:match(journal_dir) then
						return(journal_template())
					end

					-- http://lua-users.org/wiki/StringRecipes
					fname = fname:match("^.+/(.+)$"):match("(.+)%..+$")
					local function tchelper(first, rest)
					   return first:upper()..rest:lower()
					end
					fname = '# '..fname:gsub("(%a)([%w_']*)", tchelper)

					return(fname)
				end
			}
		},
		template = '{{ titlee }}'
	},
	to_do = {
		symbols = {' ', '-', 'X'},
		update_parents = true,
		not_started = ' ',
		in_progress = '-',
		complete = 'X'
	},
	tables = {
		trim_whitespace = true,
		format_on_move = true,
		auto_extend_rows = true,
		auto_extend_cols = false
	},
	yaml = {
		bib = { override = false }
	},
	mappings = {
		MkdnEnter = {{'n', 'v', 'i'}, '<CR>'},
		MkdnTab = false,
		MkdnSTab = false,
		MkdnNextLink = {'n', '<Tab>'},
		MkdnPrevLink = {'n', '<S-Tab>'},
		MkdnNextHeading = {'n', ']]'},
		MkdnPrevHeading = {'n', '[['},
		MkdnGoBack = {'n', '<BS>'},
		MkdnGoForward = {'n', '<Del>'},
		MkdnCreateLink = false, -- see MkdnEnter
		MkdnCreateLinkFromClipboard = {{'n', 'v'}, '<leader>p'}, -- see MkdnEnter
		MkdnFollowLink = false, -- see MkdnEnter
		MkdnDestroyLink = {'n', '<M-CR>'},
		MkdnTagSpan = {'v', '<M-CR>'},
		MkdnMoveSource = {'n', '<F2>'},
		MkdnYankAnchorLink = {'n', 'yaa'},
		MkdnYankFileAnchorLink = {'n', 'yfa'},
		MkdnIncreaseHeading = {'n', '+'},
		MkdnDecreaseHeading = {'n', '-'},
		MkdnToggleToDo = {{'n', 'v'}, '<C-Space>'},
		MkdnNewListItem = false,
		MkdnNewListItemBelowInsert = {'n', 'o'},
		MkdnNewListItemAboveInsert = {'n', 'O'},
		MkdnExtendList = false,
		MkdnUpdateNumbering = {'n', '<leader>nn'},
		MkdnTableNextCell = {'i', '<Tab>'},
		MkdnTablePrevCell = {'i', '<S-Tab>'},
		MkdnTableNextRow = false,
		MkdnTablePrevRow = {'i', '<M-CR>'},
		MkdnTableNewRowBelow = {'n', '<leader>ir'},
		MkdnTableNewRowAbove = {'n', '<leader>iR'},
		MkdnTableNewColAfter = {'n', '<leader>ic'},
		MkdnTableNewColBefore = {'n', '<leader>iC'},
		MkdnFoldSection = false, --{'n', '<leader>f'},
		MkdnUnfoldSection = false --{'n', '<leader>F'}
	}
})
