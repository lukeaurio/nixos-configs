{ ... }:
{
  flake.modules.homeManager.desktop = {
    programs.nixcord = {
      enable = true;
      discord = {
        enable = true;
        vencord = {
          enable = true;
        };
      };
    };
  };
}
