{ ... }:
{
  flake.modules.homeManager.browser = 
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      extensions = let
          createChromiumExtensionFor = browserVersion: { id, sha256, version }:
            {
              inherit id;
              crxPath = builtins.fetchurl {
                url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
                name = "${id}.crx";
                inherit sha256;
              };
              inherit version;
            };
          createChromiumExtension = createChromiumExtensionFor (lib.versions.major pkgs.ungoogled-chromium.version);
        in [
          (createChromiumExtension {
            # Bitwarden
            id = "nngceckbapebfimnlniiiahkandclblb";
            sha256 = "sha256:1j9hjhj3sw32dg7nlzf0sb0852jna089wf3fi9610qsqyxwm368w";
            version = "2026.10.2";
          })
          (createChromiumExtension {
            # Dark Reader
            id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; #Dark Reader
            sha256 = "sha256:178ask6mgrvzr381hby1ifvfd38h1ym5bdrb56sflfpxjap5fy0b";
            version = "4.9.135";
          })
        ];        
    };
  };
}
