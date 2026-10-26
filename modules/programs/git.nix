{ ... } : {
    flake.modules.homeManager.git = {
        programs.git = {
            enable = true;
            settings.user = {
                user = "toyJig";
                email = "rainbowtoyjig@gmail.com";
            };
        };
    };
}
