{ pkgs, config, ... }:
{
   stylix = {
      enable = true;
      autoEnable = true;
      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/lukeaurio/nixos-configs/refs/heads/main/Pictures/Desktop_Backgrounds/ForestTemple.png";
        hash = "sha256-+OiCAgVZQ1TFhmnRs47S3aXdGqED9mlmvZ36gWx+RcI=";
      };
      polarity = "dark";
      
      fonts = {
        monospace = {
           package = pkgs.nerd-fonts.gohufont;
           name = "GohuFont uni14 Nerd Font";
        };
    	serif = config.stylix.fonts.monospace;
    	sansSerif = config.stylix.fonts.monospace;
    	emoji = config.stylix.fonts.monospace;
      };
   };
}
