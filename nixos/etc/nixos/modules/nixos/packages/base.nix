{ ... }:
{
  flake.modules.nixos.packages-base =
    {
      pkgs,
      ...
    }:
    {
      # MyNixOS documents this as the all-user system package set:
      # https://mynixos.com/nixpkgs/option/environment.systemPackages
      environment.systemPackages = with pkgs; [
        vim
        wget
        nano
        htop
        btop
        git
        usbutils
        openssl
        nix-tree
      ];
    };
}
