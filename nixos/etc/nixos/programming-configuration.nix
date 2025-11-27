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
    nodePackages.nodejs
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
          rust = {
            enable = true;
            crates.enable = true;
          };
          ts.enable = true;
          lua.enable = true;
          go.enable = true;
          bash.enable = true;
          #enableLSP = true;
          enableTreesitter = true;
          enableFormat = true;
        };
        viAlias = false;
        vimAlias = true;
        spellcheck = {
          enable = true;
          programmingWordlist.enable = true;
        };

        lsp = {
          # This must be enabled for the language modules to hook into
          # the LSP API.
          enable = true;

          formatOnSave = true;
          lspkind.enable = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          trouble.enable = true;
          lspSignature.enable = false; # conflicts with blink in maximal
          otter-nvim.enable = true;
          nvim-docs-view.enable = true;
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };
        startPlugins = [
          "harpoon"
          "nvim-notify"
          "render-markdown-nvim"
        ];
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
        visuals = {
          nvim-scrollbar.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          indent-blankline.enable = true;

          # Fun
          cellular-automaton.enable = false;
        };

        statusline = {
          lualine = {
            enable = true;
          };
        };
        #visuals.tiny-devicons-auto-colors.enable = true;
        withNodeJs = true;
        withPython3 = true;
      };
    };
  };
}
