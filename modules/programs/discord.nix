{ ... } : {
  flake.modules.homeManager.discord = { ... }: {
    programs.vesktop = {
      enable = true;
      vencord.settings = {
	autoUpdate = false; # Nix manages the package, keep autoUpdate false

	  plugins = {
	    MessageLogger = {
	      enabled = true;
	      ignoreSelf = true;
	    };
	    PauseInvitesForever.enabled = true;
	    ReverseImageSearch.enabled = true;
	    NoMiddleClickPaste.enabled = true;
	    RevealAllSpoilers.enabled = true;
	    FixSpotifyEmbeds.enabled = true;
	    FixYoutubeEmbeds.enabled = true;
	    ShowHiddenThings.enabled = true;
	    YoutubeAdblock.enabled = true;
	    BetterFolders.enabled = true;
	    SpotifyCrack.enabled = true;
	    MemberCount.enabled = true;
	    ServerInfo.enabled = true;
	    ClearURLs.enabled = true;
	    NoTrack.enabled = true;
	    petpet.enabled = true;
	    NoF1.enabled = true;
	  };
	hardwareAcceleration = true;
	disableMinSize = true;
	arRPC = true;
	tray = false;
      };
    };

    xdg.configFile."vesktop/settings/vencord/settings.json".text = builtins.toJSON {
      notifyAboutUpdates = false;
    };
  };
}
