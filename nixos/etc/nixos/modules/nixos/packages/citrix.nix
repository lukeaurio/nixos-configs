{ ... }:
{
  flake.modules.nixos.packages-citrix =
    {
      pkgs,
      ...
    }:
    let
      c_version = "26.08.0.225";
      tarball = "linuxx64-${c_version}.tar.gz";
    in
    {
      environment.systemPackages = with pkgs; [
        (citrix-workspace.overrideAttrs (old: rec {
          version = "${c_version}";
          src = ./${tarball};
        }))
      ];
    };
}
