{ self, inputs, ... }:{
  flake.modules.nixos.home-desktop = {pkgs, config, ...} :
  {
	imports = [
	  ../../../hardware-configuration.nix
		self.modules.nixos.base
		self.modules.nixos.toyjig
		inputs.g-helper-linux.nixosModules.default
	];

	nixpkgs.hostPlatform = "x86_64-linux";
	nixpkgs.overlays = [ #niri
	  (final: prev: {
	   niri = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.niri;
	   })
	];

	services.ghelper.enable = true;

###### NVIDIA/AMD GPU CONTROL ENABLING ######
	boot = { # look into
	  initrd = {
		availableKernelModules = [
		    "nvme"
		    "usb_storage"
		];
		kernelModules = [ "amdgpu" ];
	  };
	  kernelModules = [ "kvm-amd" ];
	  extraModulePackages = [ ];
	};

# Enable OpenGL
	hardware.graphics = {
	  enable = true;
	  enable32Bit = true;
	  extraPackages = with pkgs; [
		rocmPackages.clr.icd
	  ];
	};

	hardware.amdgpu = {
	  opencl.enable = true;
	};

	hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;

# Load nvidia driver for Xorg and Wayland
	services.xserver.videoDrivers = [
	  "amdgpu"
	  # "nvidia"
	];

# 	hardware.nvidia = {
# 	  modesetting.enable = true;
# #MANAGED BY G-HELPER-LINUX FOR NOW
# # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
# # Enable this if you have graphical corruption issues or application crashes after waking
# # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
# # of just the bare essentials.
# 	  # powerManagement.enable = false;
#
# # Fine-grained power management. Turns off GPU when not in use.
# # Experimental and only works on modern Nvidia GPUs (Turing or newer).
# 	  # powerManagement.finegrained = true;
#
# # Use the NVidia open source kernel module (not to be confused with the
# # independent third-party "nouveau" open source driver).
# 	  open = true;
#
# # Enable the Nvidia settings menu, accessible via `nvidia-settings`.
# 	  nvidiaSettings = true;
#
# 	  prime = {
# 		nvidiaBusId = "PCI:1:0:0";
# 		amdgpuBusId = "PCI:65:0:0";
#
# 		offload = {
# 		  enable = true;
# 		  enableOffloadCmd = true;
# 		};
# 	  };
#
# 	  package = config.boot.kernelPackages.nvidiaPackages.latest;
# 	};

	networking.hostName = "home-desktop";
  };

#build the actual system
  flake.nixosConfigurations.home-desktop = inputs.nixpkgs.lib.nixosSystem {
	modules = [
	  self.modules.nixos.home-desktop
		inputs.home-manager.nixosModules.home-manager {
		  home-manager = {
			useGlobalPkgs = true;
			useUserPackages = true;
			users.toyjig = self.modules.homeManager.toyjig;
		  };
		}
	{
	  nixpkgs = {
		config = {
		  nvidia.acceptLicense = true;
		  allowUnfree = true;
		};
		overlays = [self.overlays.default];
	  };
	}

	];
  };
}
