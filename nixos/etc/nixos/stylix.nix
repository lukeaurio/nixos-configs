{ pkgs, config, ... }:
{
   stylix = {
      enable = true;
      autoEnable = true;
      image = pkgs.fetchurl {
        #Forest
        #url = "https://raw.githubusercontent.com/lukeaurio/nixos-configs/refs/heads/main/Pictures/Desktop_Backgrounds/ForestTemple.png";
        #hash = "sha256-+OiCAgVZQ1TFhmnRs47S3aXdGqED9mlmvZ36gWx+RcI=";
        #desert
        #url = "https://raw.githubusercontent.com/lukeaurio/nixos-configs/refs/heads/main/Pictures/Desktop_Backgrounds/DesertVista.jpg";
        #hash = "sha256-lZjfYxB/8qDNK97W/4Oafo+R26eImOLe6nLvWhZb6+M=";
        url = "https://raw.githubusercontent.com/lukeaurio/nixos-configs/refs/heads/main/Pictures/Desktop_Backgrounds/ScalableTemple.png";
        hash = "sha256-Mj8ZSiJ3ksH4fyfU60GOaSAnmBxWVIxBhw807bmm/2I=";
      };
      polarity = "dark";
      
      fonts = {
        monospace = {
           package = pkgs.nerd-fonts.hasklug;
           name = "Hasklug Nerd Font Mono";
        };
    	serif = config.stylix.fonts.monospace;
    	sansSerif = config.stylix.fonts.monospace;
    	emoji = config.stylix.fonts.monospace;
      };
   };
}
