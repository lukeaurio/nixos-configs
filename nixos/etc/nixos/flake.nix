{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lazyvim = {
      url = "github:pfassina/lazyvim-nix";
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

  outputs =
    {
      self,
      nixpkgs,
      nix-vscode-extensions,
      lazyvim,
      ...
    }@inputs:
    let
      pkgs =
        sys:
        import nixpkgs {
          system = sys;
          overlays = [ inputs.nix-vscode-extensions.overlays.default ];
          config = {
            allowUnfree = true;
          };
        };
    in
    {
      # use "nixos", or your hostname as the name of the configuration
      # it's a better practice than "default" shown in the video
      nixosConfigurations.framework-nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          {
            nix.settings.experimental-features = [
              "nix-command"
              "flakes"
            ];
            boot.initrd.kernelModules = [ "pinctrl_tigerlake" ];
            boot.kernelModules = [ "sg" ];
            nixpkgs.overlays = [
              inputs.nix-vscode-extensions.overlays.default
            ];
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
              inputs.lazyvim.homeManagerModules.default
            ];
          }
          inputs.stylix.nixosModules.stylix
        ];
      };
    };
}
