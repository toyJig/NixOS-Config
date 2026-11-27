{
  inputs = {
# nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
# url = "github:nix-community/home-manager/release-26.05";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nirinit = {
      url = "github:amaanq/nirinit";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";
    flake-parts.url = "github:hercules-ci/flake-parts";

    g-helper-linux = {
      url = "github:utajum/g-helper-linux?dir=nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

# programs
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    claude-code.url = "github:sadjow/claude-code-nix";
    spotx-nix = {
      url = "github:SpotX-Official/SpotX-Nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {
    inherit inputs;
  } (inputs.import-tree ./modules);
}

