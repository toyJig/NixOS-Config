{ inputs, ... } : {
	flake.modules.nixos.home-desktop = { ... }: {
		imports = [
			inputs.nirinit.nixosModules.nirinit
		];
		services.nirinit = {
			enable = true;
		};
	};
}
