{
  description = "Feature-oriented NixOS and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    caveman = {
      url = "github:JuliusBrussee/caveman";
      flake = false;
    };
    drawio-mcp = {
      url = "github:jgraph/drawio-mcp";
      flake = false;
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager"; # "github:lukeaurio/home-manager/feat/ptyxis/UpdatePaletteDefinitions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lazyvim = {
      url = "github:pfassina/lazyvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./modules ];
      systems = [ "x86_64-linux" ];
    };
}
