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
      citrix = pkgs.citrix-workspace.overrideAttrs
      (_: {
          version = "${c_version}";
          src = ./${tarball};
        }
      );
    in
    {
      environment.systemPackages = [ citrix ];
      systemd.packages = [ citrix ];
      systemd.user.services.ctxcwalogd.wantedBy = [ "default.target" ];
    };
}
