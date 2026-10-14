{ ... }:
{
  # Every file imported here is a flake-parts module. It either defines a
  # feature aspect or describes how aspects become a concrete host.
  imports = [
    ./flake-schema.nix
    ./nixos/core.nix
    ./nixos/networking.nix
    ./nixos/audio.nix
    ./nixos/peripherals.nix
    ./nixos/home-manager.nix
    ./nixos/steam.nix
    ./nixos/stylix.nix
    ./nixos/vscode-marketplace.nix
    ./nixos/desktop/plasma.nix
    ./nixos/packages/base.nix
    ./nixos/packages/desktop.nix
    ./nixos/packages/development.nix
    ./home/identity.nix
    ./home/shell.nix
    ./home/terminal.nix
    ./home/development.nix
    ./home/desktop.nix
    ./home/stylix.nix
    ./users/willberto.nix
    ./hosts/framework-nixos.nix
  ];
}
