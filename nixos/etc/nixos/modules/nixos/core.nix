{ inputs, ... }:
{
  flake.modules.nixos.core =
    {
      pkgs,
      ...
    }:
    {
      system.autoUpgrade = {
        enable = true;
        dates = "weekly";
        # Rebuild the immutable source of the current generation.  This keeps
        # the timer on the exact flake.lock input graph rather than a channel
        # or whatever happens to be in the working tree later.
        flake = "${inputs.self.outPath}#framework-nixos";
        upgrade = false;
        flags = [ "--no-update-lock-file" ];
      };

      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

      nix.settings = {
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };

      time.timeZone = "America/New_York";
      i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocaleSettings = {
          LC_ADDRESS = "en_US.UTF-8";
          LC_IDENTIFICATION = "en_US.UTF-8";
          LC_MEASUREMENT = "en_US.UTF-8";
          LC_MONETARY = "en_US.UTF-8";
          LC_NAME = "en_US.UTF-8";
          LC_NUMERIC = "en_US.UTF-8";
          LC_PAPER = "en_US.UTF-8";
          LC_TELEPHONE = "en_US.UTF-8";
          LC_TIME = "en_US.UTF-8";
        };
      };

      fonts.packages = with pkgs; [
        nerd-fonts._3270
        nerd-fonts.gohufont
        nerd-fonts.hack
        nerd-fonts.hasklug
      ];

      users.users.willberto = {
        isNormalUser = true;
        initialPassword = "ChangeMe!";
        description = "Willberto Dotbiz";
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "dialout"
          "scanner"
        ];
        shell = pkgs.zsh;
      };
      programs.zsh.enable = true;
      programs.ssh.startAgent = true;

      nixpkgs.config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "ventoy-1.1.18"
          "libsoup-2.74.3"
        ];
      };

      services.openssh.enable = true;
      system.stateVersion = "26.05";
    };
}
