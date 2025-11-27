{
  config,
  pkgs,
  ...
}: let
  gdk = pkgs.google-cloud-sdk.withExtraComponents (with pkgs.google-cloud-sdk.components; [
    gke-gcloud-auth-plugin
  ]);
in {
  environment.systemPackages = with pkgs; [
    #programming
    tailscale
    #languages / frameworks / runtimes
    python313
    poetry
    uv
    opentofu
    go
    gopls
    hugo
    #tools
    qFlipper
    ghostty
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
    #tui locations
    ncspot
    jellyfin-tui
    reddit-tui
    #vscode, editors and extensions
    platformio-core
    neovim
    #Cloud Platforms
    gdk
  ];
  services.tailscale.enable = true;
  programs.ssh.startAgent = true;

  programs.nvf = {
    enable = true;  
    # Your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
       vim = {
         languages = { 
             nix.enable = true;
             python.enable = true;
             rust.enable = true;
             go.enable = true;
             #enableLSP = true;
             enableTreesitter = true;
          };
          viAlias = false;
          vimAlias = true;
          lsp = {
             enable = true;
          };
          startPlugins = [
             "harpoon"
             "nvim-notify"
             "render-markdown-nvim"
          ];
          statusline.lualine.enable = true;
          telescope.enable = true;
          autocomplete.nvim-cmp.enable = true;
          terminal = { 
             toggleterm = {
                enable = true;
                lazygit = {
                   enable = true;
                   direction = "float";
                };
             };
             
          };
          lazy = {
             enable = true;
          };
          assistant.copilot = {
             enable = true;
             cmp.enable = true;
             setupOpts = {
                panel = {
                   enable = true;
                   position = "right";
                };
             };
          };
          #visuals.tiny-devicons-auto-colors.enable = true;
          withNodeJs = true;
          withPython3 = true;
       }; 
    };
  };
  
}
