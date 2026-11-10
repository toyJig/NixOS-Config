require('guess-indent').setup({
    on_space_options = {            -- Neovim options applied when SPACES are detected
        ["expandtab"] = false,
        ["tabstop"] = "detected",     -- "detected" dynamically inherits the measured width
        ["softtabstop"] = "detected",
        ["shiftwidth"] = "detected",
    },

    on_tab_options = {             -- Neovim options applied when TABS are detected
        ["expandtab"] = false,
    },

    buftype_exclude = {            -- Buffer types where auto-detection is disabled
        "help",
        "nofile",
        "terminal",
        "prompt",
    },
})
