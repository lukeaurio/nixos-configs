{ inputs, ... }:
{
  flake.modules.nixos.stylix =
    {
      config,
      pkgs,
      ...
    }:
    {
      imports = [ inputs.stylix.nixosModules.stylix ];

      stylix = {
        enable = true;
        autoEnable = true;
        image = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/lukeaurio/nixos-configs/refs/heads/main/Pictures/Desktop_Backgrounds/ScalableTemple.png";
          hash = "sha256-Aooohj99uA9I5UMg52tHoe8UYe0+MophMDqei8TGJLg=";
        };
        polarity = "dark";
        opacity = {
          popups = 0.7;
          terminal = 0.7;
        };
        fonts = {
          monospace = {
            package = pkgs.nerd-fonts.hasklug;
            name = "Hasklug Nerd Font Mono";
          };
          serif = config.stylix.fonts.monospace;
          sansSerif = config.stylix.fonts.monospace;
          emoji = config.stylix.fonts.monospace;
        };
        targets.nvf.transparentBackground = true;
      };
    };
}
