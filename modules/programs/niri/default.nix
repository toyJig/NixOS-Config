{ inputs, ... } : {
  flake.modules.nixos.home-desktop = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      xwayland-satellite
      xwayland
    ];

    programs.niri.enable = true;
#Enable Niri
    services.displayManager.defaultSession = "niri";

#Enable  Nirinit
    imports = [ inputs.nirinit.nixosModules.nirinit ];

    services.nirinit = {
      enable = true;
      settings = {
	skip.apps = [
	  "steam"
	    "KiCad"
	    "vesktop"
	    "noctalia"
	    "kitty"
	    "ghelper"
	];
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
