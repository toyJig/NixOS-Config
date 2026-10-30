{ inputs, ... }: {
    perSystem = { pkgs, final, system, ... }: {
        overlayAttrs = {
            unstable = import inputs.nixpkgs-unstable {
                inherit system;
            };
        };
    };

    flake.modules.nixos.niri-unstable = { pkgs, ... }: {
        nixpkgs.overlays = [
            (final: prev: {
                niri = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.niri;
            })
        ];
    };
}
