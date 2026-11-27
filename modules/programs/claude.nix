{ inputs, ... }: {
  flake.modules.nixos.claude-cli = {
    nixpkgs.overlays = [ inputs.claude-code.overlays.default ];
  };

  flake.modules.homeManager.claude-cli = { pkgs, ... }: {
    home.packages = [ pkgs.claude-code ];
  };
}
