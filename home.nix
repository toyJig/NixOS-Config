{ config, pkgs, inputs, ... }:
{
    home.stateVersion = "26.05";
    home.username = "toyjig";
    home.homeDirectory = "/home/toyjig";

    xresources.properties = {
        "Xcusor.size" = 16;
        "Xft.dpi" = 800;
    };


    imports = [
        # Explicitly import the nix-flatpak home manager module here
        inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ];

    home.packages = with pkgs; [
        nil

        #zipping
        zip
        unzip
        xz
        p7zip

        #common util
        mtr

        #markdown previewer in terminal
        glow

        #programming tools
        cmake
        python3
        gcc
        vscode-with-extensions



        #programs
        obs-studio
        discord
        inputs.zen-browser.packages."${pkgs.system}".default

    ];
    services.flatpak.packages = [
        "flathub:org.vinegarhq.Sober"
    ];

    programs.git = {
        enable = true;
        userName = "toyJig";
        userEmail = "rainbowtoyjig@gmail.com";
    };

    programs.bash = {
        enableCompletion = true;
    };

    programs.neovim = {
        enable = true;
        defaultEditor = true;
        plugins = with pkgs.vimPlugins; [
            friendly-snippets
            mini-nvim
            netrw-nvim
            nvim-lspconfig
            render-markdown-nvim
            vim-surround
        ];
    };

}
