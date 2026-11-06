vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
    end
})

vim.g.have_nerd_font = true

vim.g.netrw_banner = 0
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro rnu"

vim.o.cmdheight = 2;
vim.o.inccommand = "split"

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.smarttab = true

vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99;
vim.o.foldmethod = "expr"

vim.o.list = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"

vim.o.softtabstop = 0
vim.o.tabstop = 8

vim.o.spell = true;
vim.o.spelllang = "en_us";

vim.o.winborder = "rounded"
