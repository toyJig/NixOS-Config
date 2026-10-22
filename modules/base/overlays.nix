{ inputs, ... }:
{
    perSystem = { pkgs, final, system, ... }:
    {
        overlayAttrs = {
            unstable = import inputs.nixpkgs-unstable {
                inherit system;
            };

            polybar = pkgs.polybar.override {
                alsaSupport = false;
                mpdSupport = true;
                pulseSupport = true;
                iwSupport = true;
                nlSupport = true;
                i3Support = false; #turn on maybe to see
            };

            emacs-with-packages = pkgs.emacs.pkgs.withPackages (
            epkgs:
            (with epkgs.melpaPackages; [
                doom-modeline
                evil-collection
                magit
                zenburn-theme
            ])
            ++ [
                epkgs.nix-ts-mode
                epkgs.tree-sitter-langs
                epkgs.treesit-grammars.with-all-grammars
            ]
            );
        };
    };
}
