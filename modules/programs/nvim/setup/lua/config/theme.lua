local ok, tokyonight = pcall(require, "tokyonight")
if not ok then
    return
end

tokyonight.setup({
    style = "storm", -- Choose from "storm", "moon", "night", or "day"
    transparent = true, -- Disables background draws so Kitty's transparency shines through!
    styles = {
        sidebars = "transparent",
        floats = "transparent",
    },
})

-- Activate the color profile engine
vim.cmd([[colorscheme tokyonight]])
