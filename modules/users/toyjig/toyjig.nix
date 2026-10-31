{ self, inputs, ... }: {
    flake.modules.nixos.toyjig = {
        users.users."toyjig" = {
            isNormalUser = true;
            description = "ME ME ME ME ME";
            extraGroups = [ "wheel" "networkmanager" "video" ];
            uid = 1000;
        };
    };
    flake.modules.homeManager.toyjig = {pkgs, ...}: {
        home = {
            username = "toyjig";
            homeDirectory = "/home/toyjig";
            stateVersion = "26.05";
        };

        systemd.user.services.noctalia = {
            Service = {
                Environment = [
                    "MALLOC_CONF=background_thread:false"
                ];
            };
        };

        imports = [
            inputs.nix-flatpak.homeManagerModules.nix-flatpak
            inputs.noctalia.homeModules.default
        ] ++ (with self.modules.homeManager; [
            zen-browser
            sober

            kitty
            starship
            nvim

            vscode

            git

            noctalia
            niri
        ]);

        home.packages = with pkgs; [
            nil

            #zipping
            zip
            unzip
            xz
            p7zip

            #common util
            mtr
            findutils

            #markdown previewer in terminal
            glow

            #dev tools
            cmake
            gcc
            jdk
            gradle

            #larping
            fastfetch

            #programs
            obs-studio
            discord
            kicad
            kdePackages.kdenlive
        ];

        services.flatpak.enable = true;

    };
}
