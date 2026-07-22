{
  config,
  pkgs,
  ...
}:
let
  gdk = pkgs.google-cloud-sdk.withExtraComponents (
    with pkgs.google-cloud-sdk.components;
    [
      gke-gcloud-auth-plugin
    ]
  );
in
{
  environment.systemPackages = with pkgs; [
    #programming
    tailscale
    #languages / frameworks / runtimes
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
    #ops
    kubectl
    kubernetes-helm
    k9s
    talosctl
    talos-pilot
    #tools
    qFlipper
    ghostty
    ffmpeg
    espflash
    rpi-imager
    screen
    #command line tooling
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
    libgcc
    gccNGPackages_15.libstdcxx
    jq
    yq
    nixfmt
    ripgrep
    cowsay
    #tui locations
    ncspot
    jellyfin-tui
    reddit-tui
    #vscode, editors and extensions
    platformio-core
    neovim
    tree-sitter
    #Cloud Platforms
    gdk
    #agent stuff
    skills
  ];
  services.tailscale.enable = true;
  programs.ssh.startAgent = true;
}
