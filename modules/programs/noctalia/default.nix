{ ... }: {
    flake.modules.homeManager.noctalia = { pkgs, ... }: {
        programs.noctalia = {
            enable = true;
            systemd.enable = true;

            settings = ./setup/config.toml;
        };

        xdg.configFile."noctalia/appearance" = {
            source = ./setup/appearance;
            recursive = true;
        };
    };
}
