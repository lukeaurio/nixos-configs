{ ... }:
{
  flake.modules.homeManager.stylix = {
    stylix = {
      enable = true;
      targets = {
        vscode = {
          enable = true;
          profileNames = [
            "default"
            "Dark Modern"
          ];
        };
        floorp.profileNames = [ "default" ];
      };
    };
  };
}
