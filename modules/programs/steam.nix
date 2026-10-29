{ ... }: {
  flake.modules.homeManager.steam = { config, pkgs, lib, ... }:
    let
      patchDesktop = pkg: appName: from: to: lib.hiPrio (
        pkgs.runCommand "patched-desktop-entry-for-${appName}" { } ''
          ${pkgs.coreutils}/bin/mkdir -p $out/share/applications
          ${pkgs.gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
        ''
      );

      GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";
    in
    {
      programs.steam.enable = true;


      # Note: Home Manager uses home.packages, not environment.systemPackages
      home.packages = [
        (GPUOffloadApp pkgs.steam "steam")
        (GPUOffloadApp pkgs.heroic "com.heroicgameslauncher.hgl")
      ];
    };
}
