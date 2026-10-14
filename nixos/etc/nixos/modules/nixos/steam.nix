{ ... }:
{
  flake.modules.nixos.steam =
    {
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
      ];
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };
    };
}
