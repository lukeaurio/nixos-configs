{ ... }:
{
  flake.modules.homeManager.stylix = {
    stylix = {
      enable = true;
      targets = {
        neovim = {
          enable = true;
          plugin = "mini.base16";
          transparentBackground = {
            main = true;
          };
        };
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
