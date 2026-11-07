vim.diagnostic.config({ virtual_text = true })

local MiniCompletion = require("mini.completion")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, MiniCompletion.get_lsp_capabilities())
vim.lsp.config("*", { capabilities = capabilities })

local lua_ls_settings = vim.lsp.config.lua_ls or {}
lua_ls_settings.capabilities = vim.tbl_deep_extend("force", lua_ls_settings.capabilities or {}, capabilities)
vim.lsp.config("lua_ls", lua_ls_settings)

vim.lsp.enable({
    "basedpyright",
    "bashls",
    "clangd",
    "cssls",
    "jsonls",
    "lua_ls",
    "neocmake",
    "nixd_ls",
    "rust_analyzer",
    "superhtml",
    "taplo",
    "vtsls",
    "yamlls",
})
