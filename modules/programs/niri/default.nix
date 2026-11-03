{ inputs, ... } : {
    flake.modules.nixos.home-desktop = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [ xwayland-satellite ];
        programs.niri.enable = true;
        #Enable Niri
        services.displayManager.defaultSession = "niri";
    };
    flake.modules.homeManager.niri = { config, pkgs, ... }: {
        #Nirinit (window restorer/memory)
        home.packages = [ inputs.nirinit.packages.${pkgs.system}.default ];
        systemd.user.services.nirinit = {
            Unit = {
                Description = "Nirinit - Niri layout session manager";
                Documentation = "https://github.com";
                PartOf = [ "graphical-session.target" ];
                After = [ "graphical-session.target" ];
            };
            Service = {
                # This dynamically links to the exact binary path in Nix store
                ExecStart = "${inputs.nirinit.packages.${pkgs.system}.default}/bin/nirinit";
                Restart = "on-failure";
            };
            Install = {
                WantedBy = [ "graphical-session.target" ];
            };
        };

        xdg.configFile."niri" = {
            recursive = true;
            source = ./setup;
        };
    };
}
