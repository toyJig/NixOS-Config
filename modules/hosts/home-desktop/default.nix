{ self, inputs, ... }:
{
    flake.modules.nixos.home-desktop = {pkgs, config, ...}:
    {
        imports = [
            ../../../hardware-configuration.nix
            self.modules.nixos.base
            self.modules.nixos.toyjig
        ];

        nixpkgs.hostPlatform = "x86_64-linux";

        boot = { # look into
            initrd = {
                availableKernelModules = [
                    "nvme"
                    "usb_storage"
                ];
                kernelModules = [ ];
            };
            kernelModules = [ "kvm-amd" ];
            extraModulePackages = [ ];
        };

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
