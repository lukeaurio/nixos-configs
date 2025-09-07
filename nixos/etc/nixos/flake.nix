{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:kaylorben/nixcord";
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
           boot.kernelModules = [ "sg" ];
        }
        ./configuration.nix
        ./programming-configuration.nix
        ./kde-plasma-configuration.nix
        ./desktop-packages.nix
        ./stylix.nix
        inputs.home-manager.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.willberto = import ./home-manager/home.nix;
          home-manager.sharedModules = [
              inputs.nixcord.homeModules.nixcord
          ];
        }
        inputs.stylix.nixosModules.stylix
      ];
    };
  };
}
