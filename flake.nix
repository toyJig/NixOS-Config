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
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {
    inherit inputs;
  } (inputs.import-tree ./modules);
}

