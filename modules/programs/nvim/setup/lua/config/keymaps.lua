vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

-- Sync system clipboard
vim.opt.clipboard = "unnamedplus"
vim.keymap.set({'n', 'v', 'i'}, '<C-a>', '<Esc>ggVG', { desc = 'Select all text' })
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy selection to clipboard' })
vim.keymap.set({'n', 'v'}, '<C-v>', '"+p', { desc = 'Paste from clipboard' })
vim.keymap.set('v', '<C-x>', '"+d', { desc = 'Cut selection to clipboard' })
-- vim.keymap.set('i', '<C-v>', '<C-r>+', { desc = 'Paste from clipboard (insert)' })
vim.keymap.set({'n', 'v', 'i', 's'}, '<C-s>', '<cmd>update<cr>', { desc = 'Save' })


-- Move current line or selected block up/down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { desc = 'Move line down (insert)' })
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { desc = 'Move line up (insert)' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

vim.keymap.set({'i', 'c'}, '<C-BS>', '<C-w>', { desc = 'Delete word backwards' })
vim.keymap.set({'i', 'c'}, '<C-BS>', '<C-w>', { desc = 'Ctrl+arrow movement for hjkl' })

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


-- Blank line insertion
vim.keymap.set("n", "<C-o>", "mzo<Esc>`z", { desc = "Add line below without insert mode" })
vim.keymap.set("n", "<C-S-o>", "mzO<Esc>`z", { desc = "Add line above without insert mode" })
