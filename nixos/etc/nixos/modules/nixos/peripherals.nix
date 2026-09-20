{ ... }:
{
  flake.modules.nixos.peripherals =
    {
      pkgs,
      ...
    }:
    {
      services = {
        fwupd = {
          enable = true;
          extraRemotes = [ "lvfs-testing" ];
          uefiCapsuleSettings.DisableCapsuleUpdateOnDisk = true;
        };
        printing = {
          enable = true;
          cups-pdf.enable = true;
          drivers = with pkgs; [
            cups-filters
            cups-browsed
            canon-cups-ufr2
            cnijfilter2
          ];
        };
        udev = {
          packages = [
            pkgs.platformio-core
            pkgs.openocd
          ];
          extraRules = ''
            KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
          '';
        };
      };

      hardware = {
        bluetooth = {
          enable = true;
          powerOnBoot = true;
        };
        flipperzero.enable = true;
        sane = {
          enable = true;
          extraBackends = [ pkgs.hplipWithPlugin ];
        };
        sensor.iio.enable = true;
      };

      virtualisation.docker = {
        enable = true;
        rootless = {
          enable = true;
          setSocketVariable = true;
        };
      };
      services.xserver.xkb.layout = "us";
    };
}
