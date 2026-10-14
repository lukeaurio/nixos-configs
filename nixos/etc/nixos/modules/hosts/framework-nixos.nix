{
  config,
  ...
}:
{
  flake.modules.nixos.framework-nixos =
    {
      pkgs,
      ...
    }:
    {
      # Disk and filesystem facts deliberately stay outside the aspect tree.
      # This is the machine-specific hardware exception to the pattern.
      imports = [ ../../hardware-configuration.nix ];

      boot.initrd.kernelModules = [ "pinctrl_tigerlake" ];
      boot.kernelModules = [ "sg" ];
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_latest;
      networking.hostName = "framework-nixos";
    };

  flake.hosts.framework-nixos = {
    system = "x86_64-linux";
    module = {
      imports = with config.flake.modules.nixos; [
        framework-nixos
        core
        networking
        audio
        peripherals
        plasma
        packages-base
        packages-desktop
        packages-development
        steam
        vscode-marketplace
        stylix
        home-manager
      ];

      home-manager.users.willberto = config.flake.modules.homeManager.willberto;
    };
  };
}
