{ ... } : {
    flake.modules.nixos.home-desktop = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [xwayland-satellite];
        programs.niri.enable = true;
        #Enable Niri
        services.displayManager.defaultSession = "niri";
    };
    flake.modules.homeManager.niri = { config, ... }: {
        xdg.configFile."niri" = {
            recursive = true;
            source = ./setup;
        };
    };
}
