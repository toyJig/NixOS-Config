{ inputs, ... }: {
  flake.modules.nixos.claude = {
    nixpkgs.overlays = [ inputs.claude-code.overlays.default ];
  };

  flake.modules.homeManager.claude = { pkgs, ... }: {
    home.packages = [ pkgs.claude-code ];
    programs.antigravity.enable = true;
    programs.antigravity-cli.enable = true;
  };
}
