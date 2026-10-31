{ ... }: {
    flake.modules.nixos.home-desktop = { pkgs, ... }: {
        environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
    };
    flake.modules.homeManager.noctalia = { pkgs, config, ... }: {
        home.packages = with pkgs; [
            mpvpaper
            mpv
            socat
        ];

        programs.noctalia = {
            enable = true;
            systemd.enable = true;
            settings = (builtins.fromTOML (builtins.readFile ./setup/config.toml))
                    // (builtins.fromTOML (builtins.readFile ./setup/plugins.toml))
                    // (builtins.fromTOML (builtins.readFile ./setup/appearance.toml));
        };

        #prevent safe closes during rebuilds from cash dumping
        systemd.user.services.noctalia = {
            serviceConfig = {
                SuccessExitStatus = [ 11 ]; # 11 is SIGSEGV
            };
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
