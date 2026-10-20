{ ... }:
{
  flake.modules.nixos.packages-development =
    {
      pkgs,
      ...
    }:
    let
      googleCloudSdk = pkgs.google-cloud-sdk.withExtraComponents (
        with pkgs.google-cloud-sdk.components; [ gke-gcloud-auth-plugin ]
      );
    in
    {
      environment.systemPackages = with pkgs; [
        tailscale
        #Development runtimes
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
        #Secrets
        sops
        secretspec
        #Devops / Kube
        kubectl
        kubernetes-helm
        k9s
        talosctl
        talos-pilot
        #HaxX0r tools
        qFlipper
        #Device Management
        platformio-core
        espflash
        rpi-imager
        screen
        abcde
        #TUI / CLI Tools
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
        neovim
        tree-sitter
        #Cloud Providers
        googleCloudSdk
        #AI
        skills
      ];
    };
}
