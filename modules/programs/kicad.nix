{ ... }: {
  flake.modules.homeManager.kicad = { pkgs, ... }:
    let
    kicadWrapped = pkgs.symlinkJoin {
      name = "kicad-wrapped";
      paths = [ pkgs.kicad ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
	for bin in kicad pcbnew eeschema gerbview pl_editor bitmap2component pcb_calculator; do
	  if [ -f "$out/bin/$bin" ]; then
	    wrapProgram "$out/bin/$bin" \
              --set GDK_BACKEND x11 \
	      --set GDK_CORE_DEVICE_EVENTS 1 \
	      --set GDK_SCALE 2 \
	      --set GDK_DPI_SCALE 0.5\
	      --set vblank_mode 0
	  fi
	done
      '';
    };
  in
  {
    home.packages = [
      kicadWrapped
    ];
  };
}
