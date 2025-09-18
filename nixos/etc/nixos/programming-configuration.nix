{ config, pkgs, ...}:

{

  environment.systemPackages = with pkgs; [
    #programming
    tailscale
    #languages / frameworks / runtimes
    python313
    poetry
    uv
    opentofu
    go
    hugo
    #tools
    qflipper
    ghostty
    #command line tooling
    git-conventional-commits
    graphviz
    keychain
    tealdeer
    lazygit
    zoxide
    bat
    tree
    curl
    fzf
    ripgrep
    fd
    libgcc
    gccNGPackages_15.libstdcxx
    #tui locations
    ncspot
    jellyfin-tui
    reddit-tui
    #vscode, editors and extensions
    platformio-core
    neovim
  ];
  services.tailscale.enable = true;
  programs.ssh.startAgent = true;

  #Neovim NVF Config
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    defaultEditor = true;
  };


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
       }; 
    };
  };
  
}
