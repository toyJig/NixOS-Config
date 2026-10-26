{ ... } : {
  flake.modules.homeManager.sober = { ... }: {
    services.flatpak.packages = [
      "org.vinegarhq.Sober"
    ];
  };
}
