{ inputs, ... }: {
  flake.modules.nixos.spotx = {
    nixpkgs.overlays = [ inputs.spotx-nix.overlays.default ];
  };

  flake.modules.homeManager.spotx = { pkgs, ... }: {
    home.packages = [ pkgs.spotify-spotx ];
  };
}
