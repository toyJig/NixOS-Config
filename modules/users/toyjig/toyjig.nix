{ self, inputs, ... }: {
    flake.modules.nixos.toyjig = {
        users.users."toyjig" = {
            isNormalUser = true;
            description = "ME ME ME ME ME";
            extraGroups = [
				"wheel"
				"networkmanager"
				"video"
				"dialout"
				"uucp"
			];
            uid = 1000;
        };
    };
    flake.modules.homeManager.toyjig = {pkgs, ...}: {
        home = {
            username = "toyjig";
            homeDirectory = "/home/toyjig";
            stateVersion = "26.05";
        };

        # allow noctalia to find system programs like kate
        systemd.user.services.noctalia = {
            Service = {
                Environment = [
                    "MALLOC_CONF=background_thread:false"
                ];
            };
        };
		home.sessionVariables = {
# Tells wlroots and Niri to completely ignore the dGPU
			WLR_DRM_DEVICES = "/dev/dri/renderD128";

# Prevents Niri from trying to initialize the secondary node
			NIRI_RENDER_DRM_DEVICE = "/dev/dri/renderD128";
		};
        imports = [
            inputs.nix-flatpak.homeManagerModules.nix-flatpak
            inputs.noctalia.homeModules.default
        ] ++ (with self.modules.homeManager; [
            zen-browser
            sober
            discord

            kitty
            starship
            nvim

            vscode

            git

            noctalia
            niri
        ]);

        home.packages = with pkgs; [
            nixd
            nixfmt

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
            kicad
            kdePackages.kdenlive
            spotify
        ];

        services.flatpak.enable = true;

    };
}
