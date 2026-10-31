{
    flake.modules.nixos.base = {pkgs, ... }:
    {
        fonts.packages = with pkgs; [
            nerd-fonts.droid-sans-mono
            nerd-fonts.fira-code
            source-sans-pro
        ];

        environment.systemPackages = with pkgs; [
            unstable.nushell

            wget

            bash-language-server
            cmake-language-server
            clang-tools
            nixd

            git
        ];

        #fix vscode with extensions (gradle)
        programs.nix-ld.enable = true;
        programs.nix-ld.libraries = with pkgs; [
            stdenv.cc.cc
            zlib
        ];

        programs.firefox.enable = true;
    };
}
