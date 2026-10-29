{ self, inputs, ... }: {
    flake.modules.nixos.toyjig = {
        users.users."toyjig" = {
            isNormalUser = true;
            description = "ME ME ME ME ME";
            extraGroups = [ "wheel" "networkmanager" "video"];
            uid = 1000;
        };
    };
    flake.modules.homeManager.toyjig = {pkgs, ...}: {
        home = {
            username = "toyjig";
            homeDirectory = "/home/toyjig";
            stateVersion = "26.05";
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

            git

            noctalia
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

            #markdown previewer in terminal
            glow

            #dev tools
            cmake
            gcc
            vscode-with-extensions

            #larping
            fastfetch

            #programs
            obs-studio
            discord
            kicad
            #zen installed by zen-browser.nix
        ];

        services.flatpak.enable = true;

        programs.bash = {
            enable = true;
            enableCompletion = true;
        };

    };
}
