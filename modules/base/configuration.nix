{
  flake.modules.nixos.base = {modulesPath, pkgs, config, lib, ...}:
  {
    nix.extraOptions = "experimental-features = nix-command flakes";

    # Use the systemd-boot EFI boot loader.
    boot = {
      loader.efi.canTouchEfiVariables = true;
      loader.systemd-boot.enable = true;
      tmp.useTmpfs = true;
      kernelPackages = pkgs.linuxPackages_latest; #cannot use with nvidia settings
    };

    hardware.bluetooth.enable = true;

    networking = {
      networkmanager = {
        enable = true;
        wifi = {
          backend = "wpa_supplicant";
          powersave = false;
        };
      };
    };

    time.timeZone = "America/New_York";

    # Enable KDE Plasma 6 Environment.
    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
          options = "caps:escape";
        };

      };
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;

      printing.enable = true;

      # for noctalia
      tuned.enable = true;
      upower.enable = true;
    };

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    # Enable backlight control support
    boot.kernelParams = [ "acpi_backlight=native" ];

    nixpkgs.config.allowUnfree = true;

    #Enable Flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    #Enable flatpak
    services.flatpak.enable = true;

    #Auto prev generation cleanup
    nix.gc = {
      automatic = true;
      dates = "weekly"; # or a specific time like "*-*-* 03:00:00"
      options = "--delete-older-than 7d";
    };
    nix.settings.auto-optimise-store = true;
    boot.loader.grub.configurationLimit = 10;

    boot.extraModprobeConfig = ''
      options asus_wmi fnlock_default=N
    '';


    ###### NVIDIA GPU CONTROL ENABLING ######
    # Enable OpenGL
#     hardware.graphics = {
#       enable = true;
# #       enable32bit = true;
#     };
#
#     # Load nvidia driver for Xorg and Wayland
#     services.xserver.videoDrivers = [
#       "amdgpu"
#       "nvidia"
#     ];
#
#     hardware.nvidia = {
#
#       # Modesetting is required.
#       modesetting.enable = true;
#
#       # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
#       # Enable this if you have graphical corruption issues or application crashes after waking
#       # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
#       # of just the bare essentials.
#       powerManagement.enable = true; # false
#
#       # Fine-grained power management. Turns off GPU when not in use.
#       # Experimental and only works on modern Nvidia GPUs (Turing or newer).
#       powerManagement.finegrained = true;
#
#       # Use the NVidia open source kernel module (not to be confused with the
#       # independent third-party "nouveau" open source driver).
#       # Support is limited to the Turing and later architectures. Full list of
#       # supported GPUs is at:
#       # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
#       # Only available from driver 515.43.04+
#       open = true;
#
#       # Enable the Nvidia settings menu,
#       # accessible via `nvidia-settings`.
#       nvidiaSettings = true;
#
#       prime = {
#         nvidiaBusId = "PCI:1:0:0";
#         amdgpuBusId = "PCI:65:0:0";
#
#         offload = {
#           enable = true;
#           enableOffloadCmd = true;
#         };
#       };
#
#       # Optionally, you may need to select the appropriate driver version for your specific GPU.
#       package = config.boot.kernelPackages.nvidiaPackages.latest;
#     };
#
#     #fix shutdown on lid open
#     services = {
#       logind.settings.Login = {
#         KillUserProcesses = true;
#         LidSwitchHandle = "suspend";
#         LidSwitchExternalPowerHandle = "suspend";
#       };
#     };
#     systemd = {
#       sleep.settings.Sleep = {
#         AllowHibernation = false;
#         AllowSuspendThenHibernate = false;
#       };
#     };

    system.stateVersion = "26.05"; # DO NOT CHANGE
  };
}
