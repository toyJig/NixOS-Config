{ ... }: {
  flake.modules.homeManager.dolphin = { pkgs, ... }: {
    home.packages = with pkgs; [
	kdePackages.dolphin
	kdePackages.breeze
	kdePackages.breeze-icons
	kdePackages.qqc2-desktop-style
	kdePackages.plasma-integration
    ];

    programs.plasma = {
      enable = true;
      configFile.kdeglobals.General = {
	TerminalApplication = "kitty";
	TerminalService = "kitty.desktop";
      };
    };

# force non-use of ugly GTK file picker
    xdg.portal = {
      enable = true;
      extraPortals = [
	pkgs.kdePackages.xdg-desktop-portal-kde
	  pkgs.xdg-desktop-portal-gtk
      ];
      config.niri = {
	default = [ "gtk" ];
	"org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
	"org.freedesktop.impl.portal.Settings" = [ "gtk" ];
      };
    };
    xdg.configFile."niri-mimeapps.list".text = ''
      [Default Applications]
      inode/directory=org.kde.dolphin.desktop
    '';
  };
}
