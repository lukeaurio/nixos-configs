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
    python313
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
    lazygit
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
  ];
  services.tailscale.enable = true;
  programs.ssh.startAgent = true;
}
