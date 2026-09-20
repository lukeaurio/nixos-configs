{ ... }:
{
  flake.modules.homeManager.identity = {
    home = {
      username = "willberto";
      homeDirectory = "/home/willberto";
      stateVersion = "26.05";
    };
    programs.home-manager.enable = true;
  };
}
