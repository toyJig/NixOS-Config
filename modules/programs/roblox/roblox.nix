{ ... } : {
  flake.modules.homeManager.roblox = { pkgs, lib, ... }: {
    # Roblox Player Sober
    services.flatpak.packages = [
      "org.vinegarhq.Sober"
    ];

    # Roblox Studio Vinegar
    home.packages = with pkgs; [
      vinegar
    ];

    # Fix most stupid mouse issues (may have redundant code)
    home.activation.scaleVinegarCursors = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
       SAMPLE_CURSOR=$(${pkgs.findutils}/bin/find "$HOME/.local/share/vinegar/versions" -path "*/version-*/content/textures/Cursors/KeyboardMouse/ArrowFarCursor.png" 2>/dev/null | head -n 1)
       DEST_DIR="$HOME/.config/vinegar/overlays/studio/content/textures/Cursors/KeyboardMouse"

       if [ -n "$SAMPLE_CURSOR" ]; then
	 WIDTH=$(${pkgs.imagemagick}/bin/identify -format "%w" "$SAMPLE_CURSOR" 2>/dev/null || echo 0)
	 if [ "$WIDTH" -gt 48 ]; then
	   SRC_DIR=$(dirname "$SAMPLE_CURSOR")
	   $DRY_RUN_CMD rm -rf "$DEST_DIR"
	   $DRY_RUN_CMD mkdir -p "$DEST_DIR"
	   for f in "$SRC_DIR"/*.png; do
	     [ -e "$f" ] || continue
	     $DRY_RUN_CMD ${pkgs.imagemagick}/bin/magick "$f" \
	       -filter Lanczos -resize 36x36 \
	       -unsharp 0x0.65+1.5+0 \
	       PNG32:"$DEST_DIR/$(basename "$f")"
	   done
	 fi
       fi
   '';

    xdg.configFile."vinegar/config.toml" = {
      force = true;
      text = ''
	[studio]
	wine_root = "${pkgs.wineWow64Packages.stagingFull}"
	gpu = "0000:01:00.0"

	[studio.env]
	XCURSOR_THEME = "breeze_cursors"
	XCURSOR_SIZE = "24"
	XCURSOR_PATH = "/home/toyjig/.icons:/home/toyjig/.local/share/icons:/etc/profiles/per-user/toyjig/share/icons:/run/current-system/sw/share/icons"

	[[studio.registry]]
	key = "HKEY_CURRENT_USER\\Software\\Wine\\X11 Driver"
	name = "UseXVidMode"
	type = "REG_SZ"
	value = "N"

	[[studio.registry]]
	key = "HKEY_CURRENT_USER\\Software\\Wine\\X11 Driver"
	name = "GrabPointer"
	type = "REG_SZ"
	value = "Y"
      '';
    };
  };
}
