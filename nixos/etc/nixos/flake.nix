{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
    nixosConfigurations.framework-nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        { 
           nix.settings.experimental-features = ["nix-command" "flakes"];
           boot.initrd.kernelModules = [ "pinctrl_tigerlake" ]; 
        }
        ./configuration.nix
        ./programming-configuration.nix
        ./kde-plasma-configuration.nix
        ./desktop-packages.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
