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
        ghostty = {
          opacity = {
            enable = true;
          };
        };
        floorp.profileNames = [ "default" ];
      };
    };
  };
}
