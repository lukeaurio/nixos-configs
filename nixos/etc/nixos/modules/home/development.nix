{ ... }:
{
  flake.modules.homeManager.development =
    {
      pkgs,
      ...
    }:
    {
      programs.lazyvim = {
        enable = true;
        pluginSource = "nixpkgs";
        ignoreBuildNotifications = true;
        extras = {
          ai.copilot.enable = true;
          lang = {
            docker.enable = true;
            go.enable = true;
            helm.enable = true;
            markdown.enable = true;
            nix.enable = true;
            python.enable = true;
            terraform.enable = true;
            yaml.enable = true;
          };
          editor = {
            fzf.enable = true;
            telescope.enable = true;
          };
          formatting.black.enable = true;
        };
        extraPackages = with pkgs; [
          nixd
          pyright
          black
          alejandra
          ripgrep
          fd
        ];
        plugins.everforest = ''
          return {
            {
              "neanias/everforest-nvim",
              version = false,
              lazy = false,
              priority = 1000,
              config = function()
                require("everforest").setup({
                  background = "hard",
                  transparent_background_level = 0,
                  italics = true,
                  disable_italic_comments = false,
                  sign_column_background = "none",
                  ui_contrast = "low",
                  dim_inactive_windows = false,
                  diagnostic_text_highlight = true,
                  diagnostic_virtual_text = "coloured",
                  spell_foreground = false,
                })
              end,
            },
            {
              "LazyVim/LazyVim",
              opts = { colorscheme = "everforest"; },
            }
          }
        '';
      };

      programs.vscode = {
        enable = true;
        mutableExtensionsDir = false;
        profiles.default = {
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;
          userSettings = {
            "git.autofetch" = true;
            "git.mergeEditor" = true;
            "editor.formatOnSave" = true;
            "editor.formatOnPaste" = true;
            "editor.minimap.enabled" = true;
            "editor.stickyScroll.enabled" = true;
            "extensions.autoUpdate" = false;
            "update.mode" = "none";
            "files.autoSave" = "onFocusChange";
            "[markdown]"."editor.quickSuggestions" = true;
            "markdown.editor.pasteUrlAsFormattedLink.enabled" = "smart";
            "markdown.validate.enabled" = true;
          };
          extensions = with pkgs.vscode-marketplace-release; [
            bbenoist.nix
            ms-python.python
            ms-python.vscode-pylance
            ms-python.pylint
            ms-python.debugpy
            golang.go
            hashicorp.terraform
            ms-azuretools.vscode-docker
            ms-vscode-remote.remote-ssh
            platformio.platformio-ide
            budparr.language-hugo-vscode
            rust-lang.rust-analyzer
            ms-vscode.cpptools
            ms-vscode.cpptools-extension-pack
            openai.chatgpt
            github.copilot-chat
            github.vscode-github-actions
            mhutchie.git-graph
            waderyan.gitblame
          ];
        };
      };
    };
}
