-- Force Neovim's built-in tree-sitter engine to map 'org' files to the org parser
vim.treesitter.language.register("org", "org")

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
    local buffer = args.buf
    local filetype = vim.bo[buffer].filetype

    local language = vim.treesitter.language.get_lang(filetype) or filetype

    -- Safe execution hook
    pcall(vim.treesitter.start, buffer, language)
    end,
})
