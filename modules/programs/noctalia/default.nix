{ ... }: {
    flake.modules.nixos.home-desktop = { pkgs, ... }: {
        environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
    };
    flake.modules.homeManager.noctalia = { pkgs, config, ... }: {
        home.packages = with pkgs; [
            mpvpaper
            mpv

        ];

        programs.noctalia = {
            enable = true;
            systemd.enable = true;
            settings = (builtins.fromTOML (builtins.readFile ./setup/config.toml))
                    // (builtins.fromTOML (builtins.readFile ./setup/appearance.toml))
                    // (builtins.fromTOML (builtins.readFile ./setup/plugins.toml));
        };
        xdg.userDirs = {
            enable = true;
            createDirectories = true;
        };
        home.file."${config.xdg.userDirs.pictures}/Wallpapers" = {
            source = ./setup/wallpapers;
            recursive = true;
            force = false;
        };
    };
}
