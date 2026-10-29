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
            clang-tools
            cmake-language-server
            nixd

            git

            noctalia
        ];

        # Install firefox
        programs.firefox.enable = true;
    };
}
