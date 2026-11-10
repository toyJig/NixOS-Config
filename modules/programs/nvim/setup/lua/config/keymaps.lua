vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

-- Sync system clipboard
vim.opt.clipboard = "unnamedplus"
vim.keymap.set({'n', 'v', 'i', 's'}, '<C-s>', '<cmd>update<cr>', { desc = 'Save' })
vim.keymap.set({'n', 'v', 'i'}, '<C-a>', '<Esc>ggVG', { desc = 'Select all text' })
vim.keymap.set({"i", "v"}, "<C-c>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy selection to clipboard' })
vim.keymap.set('v', '<C-x>', '"+d', { desc = 'Cut selection to clipboard' })
vim.keymap.set({'n', 'v'}, '<C-v>', '"+]p', { desc = 'Paste from clipboard' })
vim.keymap.set('i', '<C-v>', '<C-o>"+]p', { desc = 'Paste from clipboard (insert)', remap = false })
-- Paste and auto-indent
vim.keymap.set("n", "p", "]p")
vim.keymap.set("n", "P", "]P")
vim.keymap.set("v", "p", '"_d+]p')

-- Move current line or selected block up/down
vim.keymap.set({'i', 'c'}, '<C-BS>', '<C-w>', { desc = 'Delete word backwards' })
vim.keymap.set({'i', 'c'}, '<C-BS>', '<C-w>', { desc = 'Ctrl+arrow movement for hjkl' })
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { desc = 'Move line down (insert)' })
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { desc = 'Move line up (insert)' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })

-- Blank line insertion
vim.keymap.set('n', '<leader>o', 'mzo<Esc>`z', { desc =  "Add line below without insert mode"})
vim.keymap.set('n', '<leader>O', 'mzO<Esc>`z', { desc = "Add line above without insert mode" })

-- Power movement
-- Panes
vim.keymap.set('n', '<leader>h', '<C-w>h', { desc = 'Move to left pane' })
vim.keymap.set('n', '<leader>j', '<C-w>j', { desc = 'Move to bottom pane' })
vim.keymap.set('n', '<leader>k', '<C-w>k', { desc = 'Move to top pane' })
vim.keymap.set('n', '<leader>l', '<C-w>l', { desc = 'Move to right pane' })

-- Left / Right Word (Normal, Visual)
vim.keymap.set({'n', 'v'}, '<C-h>', 'b', { desc = 'Move word left' })
vim.keymap.set({'n', 'v'}, '<C-l>', 'w', { desc = 'Move word right' })

-- Left / Right Word (Insert)
vim.keymap.set('i', '<C-h>', '<C-o>b', { desc = 'Move word left' })
vim.keymap.set('i', '<C-l>', '<C-o>w', { desc = 'Move word right' })

-- Left / Right Word (Terminal)
vim.keymap.set('t', '<C-h>', [[<C-\><C-n>bi]], { desc = 'Move word left' })
vim.keymap.set('t', '<C-l>', [[<C-\><C-n>wi]], { desc = 'Move word right' })

-- Up / Down (Insert)
vim.keymap.set('i', '<C-j>', '<Down>', { desc = 'Move down 1 line' })
vim.keymap.set('i', '<C-k>', '<Up>', { desc = 'Move up 1 line' })

-- Up / Down 5 Lines (Normal, Visual)
vim.keymap.set({'n', 'v'}, '<C-j>', '5j', { desc = 'Move down 5 lines' })
vim.keymap.set({'n', 'v'}, '<C-k>', '5k', { desc = 'Move up 5 lines' })

-- Up / Down 5 Lines (Terminal)
vim.keymap.set('t', '<C-j>', [[<C-\><C-n>5ji]], { desc = 'Move down 5 lines' })
vim.keymap.set('t', '<C-k>', [[<C-\><C-n>5ki]], { desc = 'Move up 5 lines' })

-- Ctrl + P: Find files by name (VS Code Ctrl+P)
vim.keymap.set('n', '<C-p>', function() require('telescope.builtin').find_files() end, { desc = 'Fuzzy find files' })
-- Ctrl + F: Search text inside all files (VS Code Global Find)
vim.keymap.set('n', '<leader>f', function() require('telescope.builtin').live_grep() end, { desc = 'Search text across files' })
-- Leader + b: Switch between open buffers/tabs
vim.keymap.set('n', '<leader>b', function() require('telescope.builtin').buffers() end, { desc = 'Find open buffers' })

vim.keymap.set("n", "<leader>bd", "<cmd>bp | bd #<cr>", { desc = "Close buffer, keep layout", silent = true })

-- Keymap to toggle between the 2 tabs using Ctrl+Tab
local last_tab = 1
vim.api.nvim_create_autocmd("TabLeave", {
	callback = function()
		last_tab = vim.fn.tabpagenr()
	end,
})
vim.keymap.set("n", "<C-Tab>", function()
	-- Check if the last tab is still valid (in case it was closed)
	if vim.fn.tabpagenr("$") >= last_tab then
		vim.cmd("tabnext " .. last_tab)
	else
		-- Fallback to next tab if tracking fails
		vim.cmd("tabnext")
	end
end, { desc = "Toggle between last two tabs" })

-- Dynamically split vertically or horizontally based on window aspect ratio
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.keymap.set("n", "<C-w>n", function()
	local width = vim.api.nvim_win_get_width(0)
	local height = vim.api.nvim_win_get_height(0)

	if width > (height * 1.2) then
		vim.cmd("vnew") -- More wide than tall -> vertical split
	else
		vim.cmd("new")  -- More tall than wide -> horizontal split
	end
end, { desc = "Smart new split pane based on aspect ratio" })

-- Automatically go to the correct indentation when entering insert mode
-- Ensure legacy engines don't fight guess-indent/Treesitter
vim.opt.smartindent = false
vim.opt.autoindent = true
vim.opt.expandtab = false
vim.cmd("filetype plugin indent on")
-- Define the smart indent behavior function
local function smart_insert(key)
	local line = vim.api.nvim_get_current_line()
	-- If the line is completely blank or only contains whitespace
	if line:match("^%s*$") then
		return '"_cc"'
	else
		return key
	end
end

-- Safely bind all standard insert mode entry points
vim.keymap.set('n', 'i', function() return smart_insert('i') end, { expr = true, noremap = true })
vim.keymap.set('n', 'a', function() return smart_insert('a') end, { expr = true, noremap = true })
vim.keymap.set('n', 's', function() return smart_insert('s') end, { expr = true, noremap = true })
vim.keymap.set('n', 'I', function() return smart_insert('I') end, { expr = true, noremap = true })
vim.keymap.set('n', 'A', function() return smart_insert('A') end, { expr = true, noremap = true })
vim.keymap.set('n', 'S', function() return smart_insert('S') end, { expr = true, noremap = true })

-- Toggle netrw on the left side targeting the current file's directory
vim.keymap.set('n', '<leader>e', function()
	if vim.bo.filetype == 'netrw' then
		vim.cmd('Rexplore')
	else
		local current_dir = vim.fn.expand('%:p:h')
		vim.cmd(string.format('Lex %s', current_dir))
	end
end, { desc = 'Toggle netrw sidebar in current file directory' })
