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

        programs.firefox.enable = true;
    };
}
