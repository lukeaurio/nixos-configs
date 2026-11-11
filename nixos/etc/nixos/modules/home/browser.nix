{ ... }:
{
  flake.modules.homeManager.browser = 
    {
      pkgs,
      ...
    }:
    {
    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      extensions = [
        {id = "nngceckbapebfimnlniiiahkandclblb";} #bitwarden
        {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} #Dark Reader
      ];
    };
  };
}
