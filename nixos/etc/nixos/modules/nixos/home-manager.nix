{
  inputs,
  ...
}:
{
  flake.modules.nixos.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      sharedModules = [
        inputs.nixcord.homeModules.nixcord
        inputs.lazyvim.homeManagerModules.default
      ];
    };
  };
}
