{ inputs, ... }:
{
    perSystem = { pkgs, final, system, ... }:
    {
        overlayAttrs = {
            unstable = import inputs.nixpkgs-unstable {
                inherit system;
            };


        };
    };
}
