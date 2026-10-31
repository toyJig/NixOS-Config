vim.cmd("syntax on")
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

-- -- 2. Bootstrap lazy.nvim (Plugin Manager)
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not (vim.uv or vim.loop).fs_stat(lazypath) then
--     local out = vim.fn.system({
--         "git",
--         "clone",
--         "--filter=blob:none",
--         "--branch=stable",
--         "https://github.com",
--         lazypath,
--     })
--
--     if vim.v.shell_error ~= 0 then
--         vim.api.nvim_echo({
--             { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
--             { out, "WarningMsg" },
--             { "\nPress any key to exit..." },
--         }, true, {})
--         vim.fn.getchar()
--         os.exit(1)
--     end
-- end
-- vim.opt.rtp:prepend(lazypath)

-- Safety check: Make sure lazy actually loaded before running .setup()
-- local status_ok, lazy = pcall(require, "lazy")
-- if not status_ok then
--     print("Waiting for lazy.nvim... Please restart Neovim.")
--     return
-- end

-- -- 3. Load Plugins
-- lazy.setup({
--     -- Colorscheme
--     {
--         "folke/tokyonight.nvim",
--         lazy = false,
--         priority = 1000,
--         config = function()
--         vim.cmd([[colorscheme tokyonight-night]])
--         end,
--     },
--
-- Treesitter (Syntax Highlighting)
-- {
--     "nvim-treesitter/nvim-treesitter",
-- --     build = ":TSUpdate",
--     config = function()
--     require("nvim-treesitter.configs").setup({
--         ensure_installed = { "lua", "nix", "cpp", "java", "python" },
--         highlight = { enable = true },
--     })
--     end,
-- },

-- LSP Config & Autocomplete Engine
-- {
--     "neovim/nvim-lspconfig",
--     dependencies = {
--         "hrsh7th/nvim-cmp",
--         "hrsh7th/cmp-nvim-lsp",
--         "hrsh7th/cmp-buffer",
--         "hrsh7th/cmp-path",
--         "L3MON4D3/LuaSnip",
--         "saadparwaiz1/cmp_luasnip",
--     },
--     config = function()
--     local cmp = require("cmp")
--     local lspconfig = require("lspconfig")
--
--     cmp.setup({
--         snippet = {
--             expand = function(args) require('luasnip').lsp_expand(args.body) end,
--         },
--         mapping = cmp.mapping.preset.insert({
--             ['<C-Space>'] = cmp.mapping.complete(),
--             ['<CR>'] = cmp.mapping.confirm({ select = true }),
--         }),
--         sources = cmp.config.sources({
--             { name = 'nvim_lsp' },
--             { name = 'luasnip' },
--         }, {
--             { name = 'buffer' },
--             { name = 'path' },
--         })
--     })
--
--     local capabilities = require('cmp_nvim_lsp').default_capabilities()
--
--     -- Systems LSPs (instantly mapped from your Nix extraPackages block)
--     lspconfig.nil_ls.setup({ capabilities = capabilities })
--     lspconfig.clangd.setup({ capabilities = capabilities })
--     lspconfig.jdtls.setup({ capabilities = capabilities })
--     lspconfig.pyright.setup({ capabilities = capabilities })
--     end,
--     }
-- })
