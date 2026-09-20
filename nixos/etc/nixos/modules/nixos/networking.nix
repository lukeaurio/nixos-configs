{ ... }:
{
  flake.modules.nixos.networking =
    {
      pkgs,
      ...
    }:
    {
      networking.networkmanager = {
        enable = true;
        plugins = [ pkgs.networkmanager-openvpn ];
      };
      networking.firewall.allowedUDPPorts = [ 41641 ];

      services = {
        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
        tailscale.enable = true;
      };
    };
}
