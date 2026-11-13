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

		services = {
			pipewire = {
				enable = true;
				alsa.enable = true;
				alsa.support32Bit = true;
				pulse.enable = true;
				wireplumber.enable = true;
			};
			xserver = {
				enable = true;
				xkb = {
					layout = "us";
					variant = "";
					options = "caps:escape";
				};

			};
# Enable KDE Plasma 6 Environment.
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
		boot.loader.systemd-boot.configurationLimit = 10;

#
#fix shutdown on lid open
# services = {
#   logind.settings.Login = {
#     KillUserProcesses = true;
#     LidSwitchHandle = "suspend";
#     LidSwitchExternalPowerHandle = "suspend";
#   };
# };
# systemd = {
#   sleep.settings.Sleep = {
#     AllowHibernation = false;
#     AllowSuspendThenHibernate = false;
#   };
# };

		system.stateVersion = "26.05"; # DO NOT CHANGE
	};
}
