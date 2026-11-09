{ inputs, ... } : {
    flake.modules.nixos.home-desktop = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [ xwayland-satellite ];
        programs.niri.enable = true;
        #Enable Niri
        services.displayManager.defaultSession = "niri";

        #Enable  Nirinit
        imports = [ inputs.nirinit.nixosModules.nirinit ];

        services.nirinit = {
          enable = true;
          settings = {
            launch = {
              "chrome-discord.com__app-Default" = "discord-web-app";
            };
            skip.apps = [ "steam"  "kicad" ];
          };
        };
    };
    flake.modules.homeManager.niri = { config, pkgs, ... }: {
        xdg.configFile."niri" = {
            recursive = true;
            source = ./setup;
        };
    };
}
