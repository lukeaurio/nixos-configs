{ config, ... }:
{
  # A user profile is composition only: reusable features stay in modules/home.
  flake.modules.homeManager.willberto = {
    imports = with config.flake.modules.homeManager; [
      identity
      shell
      terminal
      development
      desktop
      stylix
    ];
  };
}
