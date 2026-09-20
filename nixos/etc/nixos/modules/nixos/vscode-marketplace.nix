{ inputs, ... }:
{
  flake.modules.nixos.vscode-marketplace = {
    nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];
  };
}
