{ ... } : {
    flake.modules.homeManager.starship = { ... } : {
        programs.starship = {
            enable = true;
            enableBashIntegration = true;

            # Tokyo Night Theme Settings
            settings = {
                format = ''
                    [░▓](#7aa2f7)[  ](bg:#7aa2f7 fg:#1d202f)[](bg:#24283b fg:#7aa2f7)$username$hostname$directory[](fg:#24283b bg:#1f2335)$git_branch$git_status[](fg:#1f2335 bg:#1a1b26)$nodejs$rust$golang$nix_shell[](fg:#1a1b26)
                    $character
                '';

                username = {
                    show_always = true;
                    style_user = "bg:#24283b fg:#cfc9c2 bold";
                    style_root = "bg:#24283b fg:#f7768e bold";
                    format = " [\\[$user]($style)";
                };

                hostname = {
                    ssh_only = false;
                    style = "bg:#24283b fg:#cfc9c2 bold";
                    format = "[@$hostname:]($style)";
                };

                directory = {
                    style = "bg:#24283b fg:#cfc9c2 bold";
                    format = "[ $path\\] ]($style)";
                    truncation_length = 3;
                    truncation_symbol = "…/";
                };

                character = {
                    success_symbol = "[❯](bold #7aa2f7)";
                    error_symbol = "[❯](bold #f7768e)";
                };

                # FIXED: Moved background color parameter inside the style variable configuration
                git_branch = {
                    symbol = "";
                    style = "bg:#1f2335 fg:#7aa2f7";
                    format = "[ $symbol $branch ]($style)";
                };

                # FIXED: Cleaned up trailing brackets and format spacing
                git_status = {
                    style = "bg:#1f2335 fg:#e0af68";
                    format = "[($all_status$ahead_behind)]($style)";
                };

                nodejs = {
                    symbol = "";
                    style = "bg:#1a1b26 fg:#9ece6a";
                    format = "[ $symbol ($version) ]($style)";
                };

                rust = {
                    symbol = "";
                    style = "bg:#1a1b26 fg:#ffa500";
                    format = "[ $symbol ($version) ]($style)";
                };

                golang = {
                    symbol = "";
                    style = "bg:#1a1b26 fg:#7cd3d7";
                    format = "[ $symbol ($version) ]($style)";
                };

                nix_shell = {
                    symbol = "❄️ ";
                    style = "bg:#1a1b26 fg:#7aa2f7";
                    format = "[ $symbol ($state) ]($style)";
                };
            };
        };
    };
}
