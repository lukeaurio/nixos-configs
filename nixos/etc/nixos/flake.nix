{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:FlameFlag/nixcord";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-vscode-extensions,
    ...
  } @ inputs: let
    overlays = [
      nix-vscode-extensions.overlay
    ];
    pkgs = sys:
      import nixpkgs {
        system = sys;
        inherit overlays;
        config = {allowUnfree = true;};
      };
  in {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
    nixosConfigurations.framework-nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        {
          nix.settings.experimental-features = ["nix-command" "flakes"];
          boot.initrd.kernelModules = ["pinctrl_tigerlake"];
          boot.kernelModules = ["sg"];
        }
        ./configuration.nix
        ./programming-configuration.nix
        ./kde-plasma-configuration.nix
        ./desktop-packages.nix
        ./stylix.nix
        inputs.home-manager.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        inputs.nvf.nixosModules.default
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
