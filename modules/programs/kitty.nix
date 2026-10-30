{ ... } : {
    flake.modules.homeManager.kitty = {
        programs.kitty = {
            enable = true;

            settings = {
                background_opacity = "0.95";
                window_padding_width = 8;
                background = "#1a1b26";
                foreground = "#a9b1d6";

                # Optional: Match selection and cursor colors to Tokyo Night specs
                selection_background = "#28344a";
                selection_foreground = "#a9b1d6";
                cursor = "#c0caf5";
                cursor_trail = 1;
            };
        };
    };
}
