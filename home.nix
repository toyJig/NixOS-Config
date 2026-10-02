{ config, pkgs, ... }:
{
    home.stateVersion = "26.05";
    home.username = "toyjig";
    home.homeDirectory = "/home/toyjig";

    xresources.properties = {
        "Xcusor.size" = 16;
        "Xft.dpi" = 800;
    };

    home.packages = with pkgs; [
        #zipping
        zip
        unzip
        xz
        p7zip

        #common util
        mtr

        glow #markdown previewer in terminal
    ];

    programs.git = {
        enable = true;
        userName = "toyJig";
        userEmail = "rainbowtoyjig@gmail.com";
    };

    programs.bash = {
        enableCompletion = true;
    };
}
