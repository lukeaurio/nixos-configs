{
  config,
  inputs,
  lib,
  ...
}:
let
  inherit (lib) mkOption types;
in
{
  # Feature files contribute deferred modules here. Hosts choose feature names,
  # rather than file paths, which permits reuse across future machines.
  options.flake.modules = mkOption {
    type = types.attrsOf (types.attrsOf types.deferredModule);
    default = { };
    description = "Feature modules, grouped by target configuration class.";
  };

  options.flake.hosts = mkOption {
    type = types.attrsOf (
      types.submodule {
        options = {
          system = mkOption {
            type = types.strMatching ".+";
            description = "Non-empty Nix platform identifier for this host.";
          };
          module = mkOption {
            type = types.deferredModule;
            description = "The host module that imports its selected aspects.";
          };
        };
      }
    );
    default = { };
    description = "Host inventory used to construct nixosConfigurations.";
  };

  config.flake.nixosConfigurations = lib.mapAttrs (
      _: host:
      inputs.nixpkgs.lib.nixosSystem {
        system = host.system;
        modules = [ host.module ];
      }
    ) config.flake.hosts;
}
