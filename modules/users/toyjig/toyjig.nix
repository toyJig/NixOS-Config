{ self, inputs, ... }: {
    flake.modules.nixos.toyjig = {
        users.users."toyjig" = {
            isNormalUser = true;
            description = "ME ME ME ME ME";
            extraGroups = [
                "networkmanager"
                "wheel"
                "users"
            ];
            uid = 1000;
        };
    };
    flake.modules.homeManager.toyjig = {pkgs, ...}: {
        home = {
            username = "toyjig";
            homeDirectory = "/home/toyjig";
            stateVersion = "25.11";
        };

        imports = [
            # Explicitly import the nix-flatpak home manager module here
            inputs.nix-flatpak.homeManagerModules.nix-flatpak
            self.modules.homeManager.zen-browser
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

            #dev tools
            cmake
            python3
            gcc
            vscode-with-extensions


            #programs
            obs-studio
            discord
            #installed by zen-browser.nix?
#             inputs.zen-browser.packages."${pkgs.system}".default

        ];

        services.flatpak = {
            enable = true;
            packages = [
                "flathub:org.vinegarhq.Sober"
            ];
        };

        programs.git = {
            enable = true;
            settings.user = {
                user = "toyJig";
                email = "rainbowtoyjig@gmail.com";
            };
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
    };
}
