{ ... }:
{
  flake.modules.nixos.packages-development =
    {
      pkgs,
      ...
    }:
    let
      googleCloudSdk = pkgs.google-cloud-sdk.withExtraComponents (
        with pkgs.google-cloud-sdk.components;
        [ gke-gcloud-auth-plugin ]
      );
    in
    {
      environment.systemPackages = with pkgs; [
        tailscale
        python314
        poetry
        uv
        opentofu
        tofu-ls
        go
        gopls
        hugo
        nodejs
        rustup
        rust-analyzer
        kubectl
        kubernetes-helm
        k9s
        talosctl
        talos-pilot
        qFlipper
        ghostty
        ffmpeg
        espflash
        rpi-imager
        screen
        abcde
        git-conventional-commits
        graphviz
        keychain
        tealdeer
        lazydocker
        zoxide
        bat
        tree
        curl
        fzf
        ripgrep
        fd
        jq
        yq
        nixfmt
        cowsay
        ncspot
        jellyfin-tui
        reddit-tui
        platformio-core
        neovim
        tree-sitter
        googleCloudSdk
        skills
      ];
    };
}
