{ ... }:
{
  flake.modules.nixos.plasma =
    {
      pkgs,
      ...
    }:
    {
      services.desktopManager.plasma6.enable = true;
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };

      environment.systemPackages = with pkgs; [
        kdePackages.kcalc
        kdePackages.kcharselect
        kdePackages.kcolorchooser
        kdePackages.kolourpaint
        kdePackages.ksystemlog
        kdePackages.sddm-kcm
        kdePackages.krohnkite
        kdePackages.kwallet
        kdePackages.plasma-mobile
        kdePackages.plasma-keyboard
        kdePackages.qtvirtualkeyboard
        kdiff3
        kdePackages.isoimagewriter
        kdePackages.partitionmanager
        hardinfo2
        kdePackages.k3b
        kdePackages.skanpage
        gtk3
        haruna
        wayland-utils
        wl-clipboard
        iio-sensor-proxy
        brave
        libinput
      ];
    };
}
